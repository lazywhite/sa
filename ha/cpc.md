## Resource type
```
primitive  
clone  
group  
multi-state  
```
## Preparation

```
disable iptables selinux networkmanager
short hostname
ntp time
cluster information stored in /var/lib/pacemaker
logfile: /var/log/messages
```

## Installation
```
yum install corosync pacemaker crmsh
mv /dev/random /dev/random.bak
ln -s /dev/urandom /dev/random
corosync-keygen
service corosync start
crm status
corosync-objctl | grep members | grep ip
```
  
## Configuration files
### corosync.conf
```
compatibility: whitetank
totem {
    version: 2 
    secauth: on 
    threads: 0 
    interface { 
        ringnumber: 0 
        bindnetaddr: 172.16.0.0 
        mcastaddr: 226.94.10.10 
        mcastport: 5405 
        ttl: 1 
    } 
}
logging {
    fileline: off 
    to_stderr: no 
    to_logfile: yes 
    to_syslog: no 
    logfile: /var/log/cluster/corosync.log 
    debug: off 
    timestamp: on 
    logger_subsys { 
        subsys: AMF 
        debug: off 
    } 
}
amf {
    mode: disabled 
}
service { 
    ver: 0
    name: pacemaker
} 
aisexec {  
    user: root
    group: root
}
```
## enable quorum
```
cat << END >> /etc/corosync/corosync.conf
quorum {
provider: corosync_votequorum
			  expected_votes: 2
}
END
```

## Usage
### crm_mon
```
crm_mon --help

	crm_mon -1
	crm_mon --group-by-node --inactive
	crm_mon --daemon --as-html /path/to/docroot/cluster.html
	(not stable)
```

### corosync-cfgtool
```
corosync-cfgtool -h
	
A tool for displaying and configuring active parameters within corosync.
options:
	-s	Displays the status of the current rings on this node.
	-r	Reset redundant ring state cluster wide after a fault to
		re-enable redundant ring operation.
	-l	Load a service identified by name.
	-u	Unload a service identified by name.
	-a	Display the IP address(es) of a node
	-c	Set the cryptography mode of cluster communications
	-k	Kill a node identified by node id.
	-H	Shutdown corosync cleanly on this node.
```
  
### corosync-quorumtool

### crm shell
```
crm configure show

crm_verify -L -V
crm configure property stonith-enabled=false

crm configure primitive IP ocf:heartbeat:IPaddr2 params ip=10.10.2.100 cidr_netmask=32 op monitor interval=30s

crm ra classes
crm ra list lsb 
crm resource status IP

node2: service corosync stop

crm configure property no-quorum-policy=ignore

crm configure primitive Site ocf:heartbeat:apache params configfile=/etc/http/conf/httpd.conf statusurl="http://localhost/server-status" op monitor interval=1min
commit

crm configure op_defaults timeout=240s
crm_resource --resource Site --cleanup --node node1(cleanup resource error state)

crm configure colocation ip-with-site INFINITY: IP Site
crm configure delete IP|ip-with-site
crm resource list
crm resource show IP
			meta IPaddr
crm configure location prefer-node1 IP 50: node1
crm resource move IP node1 (manally controll resource)
crm resource unmove IP (hand over controll to cluster) 
crm resource migrate IP node2

crm ra info IPaddr2

crm configure property stonith-enabled=false
crm configure property no-quorum-policy=ignore
crm configure property default-resource-stickiness=100
crm configure colocation vip-with-haproxy INFINITY: VIP HAPROXY
crm configure order vip-before-haproxy Mandatory: VIP HAPROXY
```

