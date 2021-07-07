## Introduction
note for linux system administration

## Directory Layout 

```
├── android
│   ├── jenkins_android.sh
│   └── note.md
├── appserver
│   ├── jetty
│   ├── tomcat
│   └── weblogic
├── auto
│   ├── ansible
│   ├── foreman.md
│   ├── puppet
│   └── saltstack
├── bigdata
│   ├── ambari
│   ├── druid
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
│   ├── parquet
│   ├── phoenix
│   ├── pig
│   ├── ranger
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
│   ├── etcd
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
├── disk
│   ├── lsblk.txt
│   ├── parted.txt
│   └── raid.txt
├── dns
│   ├── bind
│   └── dnsmasq.md
├── fs
│   ├── ceph
│   ├── fastdfs
│   ├── ftpfs
│   ├── gfs2
│   ├── gluster
│   ├── iscsi
│   ├── lvm
│   ├── minio
│   ├── mogilefs
│   ├── nfs
│   ├── samba
│   ├── sshfs
│   └── zfs
├── ftp
│   ├── client.txt
│   ├── filezilla.txt
│   ├── ftp_client.sh
│   ├── ftp-server.sh
│   ├── lftp.md
│   ├── sftp.txt
│   └── vsftp.md
├── ha
│   ├── drbd8
│   ├── drbd9
│   ├── keepalived
│   └── pacemaker
├── image
│   ├── 143256261.jpg
│   ├── 2033581_1369962477MN7p.jpg
│   ├── 2033581_13699627772B10.jpg
│   ├── 2033581_1369962848eEh1.jpg
│   ├── 2033581_1369962958hvxf.jpg
│   ├── 2033581_1369963124kxNd.jpg
│   ├── 2033581_1369963308D7At.jpg
│   ├── 2033581_1369963393EOGB.jpg
│   ├── 2033581_1370221372VEAi.jpg
│   ├── iproute2.png
│   ├── java_run_process.jpg
│   ├── tcpfsm.png
│   └── vcl.png
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
│   ├── account.txt
│   ├── build_minimal_linux.txt
│   ├── centos
│   ├── limit.txt
│   ├── password_strategy.md
│   ├── software
│   ├── sysadmin.txt
│   ├── systemd.txt
│   ├── ubuntu
│   └── webapp.txt
├── log
│   ├── logrotate
│   └── rsyslog
├── mac
│   ├── homebrew.md
│   ├── ipa_build
│   ├── note.md
│   ├── route.md
│   ├── xcode.md
│   └── xvim2.md
├── microservice
│   ├── consul
│   ├── etcd
│   ├── eureka
│   ├── hystrix
│   ├── istio
│   ├── note.md
│   ├── smartstack.md
│   └── zuul
├── ml
│   ├── note.txt
│   ├── sklearn
│   ├── tensorflow
│   ├── theano
│   ├── v2-abbf2218ddd71b68c2461101803991e8_r.jpg
│   └── v2-fb30184a45c03a68dbce2fbbd40e2e0c_r.jpg
├── monitoring
│   ├── bosun
│   ├── cadvisor
│   ├── ganglia
│   ├── grafana
│   ├── ipmi
│   ├── nagios
│   ├── prometheus
│   ├── tick
│   └── zabbix
├── mq
│   ├── activemq
│   ├── kafka
│   ├── rabbitmq
│   └── zeromq
├── netfilter
│   ├── eBPF
│   ├── ebtables
│   ├── firewalld
│   ├── iptables
│   └── note.md
├── network
│   ├── bond.txt
│   ├── bridge.txt
│   ├── hub.txt
│   ├── ipv6
│   ├── note.txt
│   ├── protocol
│   ├── router
│   ├── switch
│   └── tools
├── ntp
│   ├── chrony.txt
│   ├── note.md
│   └── ntp.conf
├── optool
│   ├── 7zip.md
│   ├── atop.md
│   ├── autossh.md
│   ├── awk.md
│   ├── awk.txt
│   ├── cobbler.md
│   ├── cronolog.md
│   ├── crontab.txt
│   ├── curl.txt
│   ├── customize_iso.txt
│   ├── dpkg.md
│   ├── dstat
│   ├── ethtool.md
│   ├── ethtool.txt
│   ├── expect.sh
│   ├── find.md
│   ├── gitbook.md
│   ├── grep.md
│   ├── hashcat.md
│   ├── htop.md
│   ├── httperf.md
│   ├── iftop.md
│   ├── iostat.md
│   ├── iotop.md
│   ├── iozone.txt
│   ├── irc.txt
│   ├── lmsensor.txt
│   ├── locate.txt
│   ├── losetup.txt
│   ├── lsof.md
│   ├── lsof.txt
│   ├── mail.md
│   ├── mpstat.md
│   ├── mtr.txt
│   ├── nc.txt
│   ├── nethogs.md
│   ├── network
│   ├── networkmanager.txt
│   ├── nload.md
│   ├── nmap.md
│   ├── nmon.md
│   ├── note.txt
│   ├── oh-my-zsh.md
│   ├── parted.md
│   ├── pxe.md
│   ├── rdp.md
│   ├── rpmbuild
│   ├── rpm.txt
│   ├── rsync.md
│   ├── sar.md
│   ├── screen.md
│   ├── securecrt.txt
│   ├── sed.md
│   ├── seq.md
│   ├── shadowsocks.txt
│   ├── slack.md
│   ├── socat.txt
│   ├── sort.md
│   ├── ss.md
│   ├── top.txt
│   ├── uniq.md
│   ├── vconfig.txt
│   ├── vim.md
│   ├── virtualization
│   ├── vmstat.md
│   ├── vnc.md
│   ├── weechat.md
│   └── yum.txt
├── os
│   ├── pthread.c
│   └── thread.txt
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
│   ├── bgp
│   ├── dns.md
│   ├── http
│   ├── https.md
│   ├── jsonrpc.md
│   ├── jwt.md
│   ├── note.md
│   └── thrift.md
├── proxy
│   ├── envoy
│   ├── forward_proxy
│   ├── note.md
│   ├── reverse_proxy
│   └── tinyproxy.md
├── README.md
├── RHCE.png
├── rsync
│   ├── note.txt
│   ├── rsyncd.conf
│   └── rsyncd.secrets
├── sdn
│   ├── faucet
│   └── openvswitch
├── security
│   ├── clamav.md
│   ├── cors.txt
│   ├── csrf.md
│   ├── ddos.md
│   ├── kerberos
│   ├── oauth.md
│   └── xss.md
├── sniffer
│   ├── bro
│   ├── charles
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
│   ├── course.txt
│   ├── experience.txt
│   ├── goal.txt
│   ├── memo.txt
│   ├── music.txt
│   ├── punctuation
│   ├── todo.txt
│   └── work_note.txt
├── vcs
│   ├── git
│   ├── gitlab
│   ├── gogs
│   └── svn
├── virtualization
│   ├── cri-o
│   ├── docker
│   ├── kubernetes
│   ├── kvm
│   ├── openstack
│   ├── rkt
│   ├── vagrant
│   ├── virtualbox
│   └── wsl
├── webserver
│   ├── apache
│   ├── lighttpd
│   ├── nginx
│   └── note.md
└── windows
    ├── cmd.md
    ├── jdk.md
    ├── note.txt
    ├── rdp.txt
    ├── salt-minion.md
    ├── virtio.md
    └── zabbix_agent.md
```
