## Introduction
note for linux system administration

## Directory Layout 

```
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
├── disk
│   └── raid.txt
├── dns
│   ├── bind
│   └── dnsmasq.md
├── firewalls
│   ├── firewalld
│   ├── iptables
│   └── note.md
├── fs
│   ├── ceph
│   ├── fastdfs
│   ├── ftpfs
│   ├── gfs2
│   ├── gluster
│   ├── iscsi
│   ├── lvm
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
│   ├── build_minimal_linux.txt
│   ├── deb_mirror.md
│   ├── image
│   ├── note.txt
│   ├── password_strategy.md
│   ├── rpm_mirror.txt
│   ├── software
│   ├── sysadmin.txt
│   ├── ubuntu
│   └── webapp.txt
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
│   └── theano
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
├── network
│   ├── bond.txt
│   ├── cisco-router.md
│   ├── nic-bridge.txt
│   ├── ntop
│   ├── route.txt
│   ├── smokeping
│   ├── switch
│   └── ubuntu
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
│   ├── customize_iso.txt
│   ├── dpkg.md
│   ├── dstat
│   ├── ethtool.txt
│   ├── experience.txt
│   ├── find.md
│   ├── gitbook.md
│   ├── grep.md
│   ├── hashcat.md
│   ├── htop.md
│   ├── iftop.md
│   ├── iostat.md
│   ├── iptables.txt
│   ├── irc.txt
│   ├── lmsensor.txt
│   ├── lsof.md
│   ├── lsof.txt
│   ├── mail.md
│   ├── mpstat.md
│   ├── nload.md
│   ├── nmap.md
│   ├── oh-my-zsh.md
│   ├── pxe.md
│   ├── rdp.md
│   ├── rpmbuild
│   ├── rsync.md
│   ├── rsyslog_logger.md
│   ├── rsyslog_redirect.md
│   ├── sar.md
│   ├── screen.md
│   ├── securecrt.txt
│   ├── sed.md
│   ├── seq.md
│   ├── shadowsocks.txt
│   ├── slack.md
│   ├── ss.md
│   ├── sublime.md
│   ├── systemd.md
│   ├── vconfig.txt
│   ├── vim.md
│   ├── vmstat.md
│   ├── vnc.md
│   ├── weechat.md
│   └── yum.txt
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
│   ├── course.txt
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
│   ├── docker
│   ├── kubernetes
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
