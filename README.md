## Introduction
note for linux system administration

## Directory Layout 

```  
├── RHCE.png
├── android
│   ├── jenkins_android.sh
│   └── note.md
├── appserver
│   ├── jetty
│   └── tomcat
├── auto
│   ├── ansible
│   ├── foreman.md
│   ├── puppet
│   └── saltstack
├── bigdata
│   ├── flume
│   ├── hadoop
│   ├── hbase
│   ├── hcatalog
│   ├── hive
│   ├── hue
│   ├── impala
│   ├── kettle
│   ├── kylin
│   ├── mahout
│   ├── matlab
│   ├── mesos
│   ├── note.txt
│   ├── pig
│   ├── spark
│   ├── sqoop
│   ├── storm
│   └── zookeeper
├── cache
│   ├── etcd
│   ├── memcache
│   └── varnish
├── database
│   ├── access
│   ├── counchdb
│   ├── greenplum
│   ├── influxdb
│   ├── mongodb
│   ├── mssql_server
│   ├── mysql
│   ├── opentsdb
│   ├── oracle
│   ├── postgresql
│   ├── redis
│   ├── sqlite
│   ├── sybase
│   └── tools
├── dns
│   ├── bind
│   └── dnsmasq.md
├── firewalls
│   ├── firewalld
│   ├── iptables
│   └── note.md
├── fs
│   ├── fastdfs
│   ├── gfs2
│   ├── gluster
│   ├── iscsi
│   ├── lvm
│   ├── mogilefs
│   ├── nfs
│   ├── samba
│   └── zfs
├── ftp
│   └── client.txt
├── ha
│   ├── Cluster.txt
│   ├── corosync.txt
│   ├── corosync_configure.md
│   ├── cpc.md
│   ├── drbd+pacemaker.txt
│   ├── keepalived
│   ├── pcs-corosync.txt
│   └── rhcs
├── ldap
│   ├── db.tar.gz
│   ├── deploy.md
│   ├── export.ldif
│   ├── ldap_tools
│   ├── modify.ldif
│   ├── note.md
│   ├── openldap
│   ├── openssh-5.9p1.tar.gz
│   └── openssh-lpk-5.9p1-0.3.14.patch
├── library
│   └── openssl.md
├── linux
│   ├── 143256261.jpg
│   ├── 2033581_1369962477MN7p.jpg
│   ├── 2033581_13699627772B10.jpg
│   ├── 2033581_1369962848eEh1.jpg
│   ├── 2033581_1369962958hvxf.jpg
│   ├── 2033581_1369963124kxNd.jpg
│   ├── 2033581_1369963308D7At.jpg
│   ├── 2033581_1369963393EOGB.jpg
│   ├── 2033581_1370221372VEAi.jpg
│   ├── cent7
│   ├── course.txt
│   ├── cronolog.md
│   ├── debian.md
│   ├── http-netstat.txt
│   ├── iproute2.png
│   ├── java_run_process.jpg
│   ├── procedure.txt
│   ├── ssh_config.md
│   ├── sysadmin.txt
│   ├── systemd
│   ├── tcpfsm.png
│   ├── ubuntu
│   ├── user.txt
│   ├── vcl.png
│   ├── vsftpd+pam+mysql.txt
│   └── webapp.txt
├── mac
│   ├── homebrew.md
│   ├── ipa_build
│   ├── note.md
│   └── route.md
├── microservice
│   ├── consul
│   ├── etcd
│   ├── eureka
│   ├── hystrix
│   ├── note.md
│   ├── smartstack.md
│   └── zuul
├── ml
│   ├── note.txt
│   ├── sklearn
│   ├── tensorflow
│   └── theano
├── monitoring
│   ├── bosun
│   ├── cadvisor
│   ├── ganglia
│   ├── grafana
│   ├── ipmi
│   ├── nagios
│   ├── tick
│   └── zabbix
├── mq
│   ├── activemq
│   ├── kafka
│   ├── rabbitmq
│   └── zeromq
├── network
│   ├── cisco-router.md
│   ├── multi_net_routing.txt
│   ├── nic-bridge.txt
│   ├── ntop
│   ├── route.txt
│   ├── smokeping
│   ├── switch
│   └── ubuntu
├── ntp
│   ├── note.md
│   └── ntp.conf
├── optool
│   ├── autossh.md
│   ├── awk.md
│   ├── awk.txt
│   ├── cobbler.md
│   ├── code-deploy.txt
│   ├── customize_iso.txt
│   ├── dstat
│   ├── experience.txt
│   ├── find.md
│   ├── gitbook.md
│   ├── grep.md
│   ├── htop.md
│   ├── iostat.md
│   ├── iptables.txt
│   ├── irc.txt
│   ├── lmsensor.txt
│   ├── lsof.md
│   ├── lsof.txt
│   ├── mpstat.md
│   ├── nmap.md
│   ├── oh-my-zsh.md
│   ├── pxe.md
│   ├── rdp.md
│   ├── rpm.md
│   ├── rsync.md
│   ├── sar.md
│   ├── screen.md
│   ├── sed.md
│   ├── seq.md
│   ├── slack.md
│   ├── ss.md
│   ├── sublime.md
│   ├── systemd.md
│   ├── vim.md
│   ├── vmstat.md
│   ├── vnc.md
│   └── weechat.md
├── performance
│   ├── cpu
│   ├── disk
│   ├── epoll.md
│   ├── filesystem
│   ├── irq.md
│   ├── kernel_parameter.txt
│   ├── memory
│   ├── network
│   └── taskset.md
├── protocol
│   ├── dns.md
│   ├── http
│   ├── https.md
│   ├── jsonrpc.md
│   ├── jwt.md
│   ├── note.md
│   └── thrift.md
├── proxy
│   ├── forward_proxy
│   ├── note.md
│   ├── reverse_proxy
│   └── tinyproxy.md
├── rsync
│   ├── note.txt
│   ├── rsyncd.conf
│   └── rsyncd.secrets
├── security
│   ├── clamav.md
│   ├── cors.txt
│   ├── csrf.md
│   ├── ddos.md
│   ├── oauth.md
│   └── xss.md
├── sniffer
│   ├── bro
│   ├── charles
│   ├── ethtool.md
│   ├── pfring.md
│   ├── tcpdump.md
│   ├── tcpreplay
│   └── wireshark
├── socket
│   ├── note.md
│   └── tcp1.jpg
├── software
│   ├── cmdbuild.md
│   ├── confluence.md
│   ├── elk
│   ├── jenkins
│   ├── jira.md
│   ├── nexus
│   └── solr
├── sync
│   ├── goal.txt
│   ├── memo.txt
│   ├── music.txt
│   ├── punctuation
│   ├── todo.txt
│   ├── upgrade_ssl_ssh_mysql.md
│   └── work_note.txt
├── vcs
│   ├── git
│   ├── gitlab
│   ├── gogs
│   └── svn
├── virtualization
│   ├── docker
│   ├── kubernate
│   ├── kvm
│   ├── openstack
│   ├── vagrant
│   └── virtualbox
├── webserver
│   ├── apache
│   ├── lighttpd
│   ├── nginx
│   └── note.md
└── windows
    ├── jdk.md
    ├── note.txt
    ├── rdp.txt
    ├── salt-minion.md
    ├── virtio.md
    └── zabbix_agent.md
```
