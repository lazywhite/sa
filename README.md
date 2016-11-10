## Introduction
My personal note for IT technology I've learned   
## Repo structure  

```  
├── andriod
│   ├── build.gradle
│   ├── jenkins-jixiang-android-cos.sh
│   ├── jenkins_android.md
│   └── note.md
├── appserver
│   ├── php
│   │   └── note.md
│   └── tomcat
│       ├── new.md
│       └── note.txt
├── auto
│   ├── ansible
│   │   └── note.md
│   ├── foreman.md
│   ├── puppet
│   │   ├── mcollective
│   │   │   ├── activemq.xml
│   │   │   ├── client.cfg
│   │   │   └── server.cfg
│   │   ├── note.md
│   │   ├── puppet-note.txt
│   │   └── puppet.txt
│   └── saltstack
│       ├── memo.txt
│       ├── note.md
│       ├── srv
│       │   └── salt
│       │       ├── files
│       │       │   ├── database.php
│       │       │   ├── hhvm
│       │       │   ├── nginx.conf
│       │       │   ├── nginx_default.conf
│       │       │   ├── php-fpm-www.conf
│       │       │   ├── php.ini
│       │       │   ├── server.hdf
│       │       │   ├── sshd_config
│       │       │   ├── start.php.tpl
│       │       │   ├── vimrc
│       │       │   └── wsrep.cnf.tpl
│       │       ├── hhvm.sls
│       │       ├── hrcf.sls
│       │       ├── maria.sls
│       │       ├── nginx.sls
│       │       ├── php55.sls
│       │       ├── sshd.sls
│       │       ├── test.sls
│       │       ├── top.sls
│       │       └── vim.sls
│       ├── syndic.md
│       └── sysdoc.txt
├── bigdata
│   ├── flume
│   │   └── note.md
│   ├── hadoop
│   │   ├── hdfs
│   │   │   ├── hdfs.md
│   │   │   ├── install.md
│   │   │   └── note.md
│   │   ├── mapreduce.md
│   │   └── note.md
│   ├── hbase
│   │   ├── crud.md
│   │   └── note.md
│   ├── hcatalog
│   │   └── note.md
│   ├── hive
│   │   └── note.md
│   ├── impala
│   │   └── note.md
│   ├── mahout
│   │   └── note.md
│   ├── mesos
│   │   └── note.md
│   ├── pig
│   │   └── note.md
│   ├── spark
│   │   ├── note.md
│   │   ├── pyspark.md
│   │   ├── simpleapp.py
│   │   ├── spark-shell.md
│   │   ├── sparkSQL.md
│   │   └── sparkStreaming.md
│   ├── storm
│   │   └── note.md
│   └── zookeeper
│       └── note.md
├── cache
│   ├── memcache
│   │   └── note.txt
│   └── varnish
│       ├── varnish.png
│       └── varnish.txt
├── database
│   ├── counchdb
│   │   └── note.md
│   ├── influxdb
│   │   ├── http-api.md
│   │   ├── note.md
│   │   ├── tick.md
│   │   ├── topic.md
│   │   └── usage.md
│   ├── mongodb
│   │   ├── MongoDB.txt
│   │   ├── command.md
│   │   ├── crud.md
│   │   ├── dump_restore.md
│   │   ├── note.md
│   │   ├── sharding.md
│   │   └── tokumx
│   │       ├── dump_oplog.sh
│   │       ├── lib.py
│   │       ├── mongodb-doc
│   │       ├── note
│   │       ├── oplog.py
│   │       └── tokumx.conf
│   ├── mysql
│   │   ├── HA
│   │   │   ├── drbd.txt
│   │   │   └── note.md
│   │   ├── backup_restore
│   │   │   └── Xtrabackup.txt
│   │   ├── installation
│   │   │   ├── compile.md
│   │   │   └── multi_instance.md
│   │   ├── isolation_level.md
│   │   ├── note.md
│   │   ├── partition.md
│   │   ├── procedure
│   │   │   ├── config_pro.sql
│   │   │   ├── game_pro.sql
│   │   │   └── log_pro.sql
│   │   ├── proxy
│   │   │   └── mysql_proxy.txt
│   │   ├── replication
│   │   │   └── note.txt
│   │   ├── semisync.md
│   │   ├── sharding
│   │   │   ├── amoeba.md
│   │   │   └── note.md
│   │   ├── sql
│   │   │   ├── mysql-command.txt
│   │   │   └── note
│   │   ├── tokudb
│   │   │   ├── tokudb.conf
│   │   │   └── tokudb.md
│   │   └── tunning
│   │       └── innodb_tuning.jpg
│   ├── opentsdb
│   │   └── note.md
│   ├── postgresql
│   │   ├── back_restore.md
│   │   ├── database_file_layout.md
│   │   ├── partition.sql
│   │   ├── pg_partition.md
│   │   ├── sql.md
│   │   └── usage.md
│   ├── redis
│   │   ├── cluster.txt
│   │   ├── cluster_note.md
│   │   ├── command.txt
│   │   ├── image_store.md
│   │   ├── install.md
│   │   ├── partition.txt
│   │   ├── redis.conf
│   │   └── repl.txt
│   ├── sqlite
│   │   └── 3sql.note
│   ├── sybase
│   │   ├── bak_restore.md
│   │   └── install.md
│   └── tools
│       └── schemaSpy.md
├── firewalls
│   ├── firewalld
│   │   └── note.md
│   ├── iptables
│   │   ├── example.sh
│   │   └── note.md
│   └── note.md
├── fs
│   ├── fastdfs
│   │   ├── README.md
│   │   ├── case
│   │   │   ├── extend.md
│   │   │   ├── img01.mmbang.info.conf
│   │   │   ├── nginx-10.8.26.13.conf
│   │   │   ├── nginx-img01.conf
│   │   │   ├── storage_grp6.conf
│   │   │   ├── store_grp6-nginx.conf
│   │   │   └── tracker_grp3.conf
│   │   ├── g1-s1-mod_fastdfs.conf
│   │   ├── g1-s1-nginx.conf
│   │   ├── g1-s1-storage.conf
│   │   ├── g2-s1-mod_fastdfs.conf
│   │   ├── g2-s1-nginx.conf
│   │   ├── g2-s1-storage.conf
│   │   ├── note.txt
│   │   ├── thumb.php
│   │   ├── tracker.conf
│   │   └── tracker_nginx.conf
│   ├── gfs2
│   │   └── note.md
│   ├── gluster
│   │   ├── install.md
│   │   └── note.md
│   ├── iscsi
│   │   ├── iscsi_tgt.md
│   │   └── note.md
│   ├── lvm
│   │   └── note.md
│   ├── mogilefs
│   │   └── note.md
│   ├── nfs
│   │   └── note.md
│   └── zfs
│       └── note.txt
├── ha
│   ├── Cluster.txt
│   ├── corosync.txt
│   ├── corosync_configure.md
│   ├── drbd+pacemaker.txt
│   ├── keepalived
│   │   └── note.md
│   ├── pcs-corosync.txt
│   └── rhcs
│       └── note.md
├── ldap
│   ├── db.tar.gz
│   ├── deploy.md
│   ├── export.ldif
│   ├── ldap_tools
│   ├── modify.ldif
│   ├── note.md
│   ├── openldap
│   │   ├── cacerts
│   │   │   ├── cacert.pem
│   │   │   ├── client.cert
│   │   │   ├── client.key
│   │   │   ├── server.cert
│   │   │   └── server.key
│   │   ├── certs
│   │   │   └── password
│   │   ├── check_password.conf
│   │   ├── ldap.conf
│   │   ├── schema
│   │   │   ├── collective.ldif
│   │   │   ├── collective.schema
│   │   │   ├── corba.ldif
│   │   │   ├── corba.schema
│   │   │   ├── core.ldif
│   │   │   ├── core.schema
│   │   │   ├── cosine.ldif
│   │   │   ├── cosine.schema
│   │   │   ├── duaconf.ldif
│   │   │   ├── duaconf.schema
│   │   │   ├── dyngroup.ldif
│   │   │   ├── dyngroup.schema
│   │   │   ├── inetorgperson.ldif
│   │   │   ├── inetorgperson.schema
│   │   │   ├── java.ldif
│   │   │   ├── java.schema
│   │   │   ├── misc.ldif
│   │   │   ├── misc.schema
│   │   │   ├── nis.ldif
│   │   │   ├── nis.schema
│   │   │   ├── openldap.ldif
│   │   │   ├── openldap.schema
│   │   │   ├── pmi.ldif
│   │   │   ├── pmi.schema
│   │   │   ├── ppolicy.ldif
│   │   │   ├── ppolicy.schema
│   │   │   └── sudoer.schema
│   │   ├── slap-repl.conf
│   │   ├── slap-repl2.conf
│   │   └── slapd.conf
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
│   ├── bzImage
│   ├── course.txt
│   ├── debian.md
│   ├── http-netstat.txt
│   ├── iproute2.png
│   ├── java_run_process.jpg
│   ├── procedure.txt
│   ├── ssh_config.md
│   ├── sysadmin.txt
│   ├── tcpfsm.png
│   ├── ubuntu.md
│   ├── vcl.png
│   ├── vsftpd+pam+mysql.txt
│   └── webapp.txt
├── mac
│   ├── ipa_build
│   │   ├── build.sh
│   │   ├── gen_plist.py
│   │   └── register.py
│   ├── note.md
│   └── route.md
├── monitoring
│   ├── bosun
│   │   ├── expression.md
│   │   └── note.md
│   ├── cadvisor
│   │   └── note.md
│   ├── ganglia
│   │   └── note.md
│   ├── grafana
│   │   └── note.md
│   ├── nagios
│   │   ├── nagios
│   │   │   ├── conf.d
│   │   │   │   ├── common_svc.cfg
│   │   │   │   ├── host_group.cfg
│   │   │   │   ├── jdq1.cfg
│   │   │   │   ├── jdq2.cfg
│   │   │   │   ├── mongo1.cfg
│   │   │   │   ├── mongo2.cfg
│   │   │   │   ├── mongo3.cfg
│   │   │   │   ├── mongo4.cfg
│   │   │   │   ├── mongo5.cfg
│   │   │   │   ├── mongo6.cfg
│   │   │   │   ├── mongo7.cfg
│   │   │   │   └── svc_group.cfg.bak
│   │   │   ├── nagios.cfg
│   │   │   ├── objects
│   │   │   │   ├── commands.cfg.rpmsave
│   │   │   │   ├── contacts.cfg.rpmsave
│   │   │   │   ├── localhost.cfg.rpmsave
│   │   │   │   └── templates.cfg.rpmsave
│   │   │   └── passwd
│   │   └── note.md
│   ├── tick
│   │   ├── kapacitor
│   │   │   ├── cpu_alert.tick
│   │   │   ├── kapacitor.conf
│   │   │   └── note.md
│   │   └── telegraf
│   │       └── usage.md
│   └── zabbix
│       ├── install-3.0.txt
│       ├── note.md
│       ├── note.txt
│       └── ubuntu-3.2
│           ├── agent
│           │   ├── zabbix-agent-init
│           │   └── zabbix_agentd.conf
│           ├── frontend
│           │   └── zabbix.conf.php
│           ├── install.md
│           ├── proxy
│           │   ├── zabbix-proxy-init
│           │   └── zabbix_proxy.conf
│           └── server
│               ├── topic.md
│               ├── zabbix-server-init
│               └── zabbix_server.conf
├── mq
│   ├── activemq
│   │   └── install.md
│   ├── kafka
│   │   └── note.md
│   ├── rabbitmq
│   │   ├── cluster.md
│   │   └── note.md
│   └── zeromq
│       ├── client.py
│       ├── connect.py
│       ├── note.md
│       ├── pairclient.py
│       ├── pairserver.py
│       ├── pub.py
│       ├── pull.py
│       ├── push.py
│       ├── server.py
│       └── sub.py
├── network
│   ├── cisco-router.md
│   ├── multi_net_routing.txt
│   ├── nic-bridge.txt
│   ├── route.txt
│   ├── route_table.md
│   └── switch.txt
├── oauth
│   └── note.md
├── optool
│   ├── awk.txt
│   ├── cobbler.md
│   ├── code-deploy.txt
│   ├── customize_iso.txt
│   ├── dstat
│   ├── experience.txt
│   ├── homebrew.md
│   ├── htop.md
│   ├── iptables.txt
│   ├── irc.txt
│   ├── lsof.md
│   ├── lsof.txt
│   ├── nmap.md
│   ├── oh-my-zsh.md
│   ├── pxe.md
│   ├── rsync.md
│   ├── sar.md
│   ├── screen.md
│   ├── seq.md
│   ├── slack.md
│   ├── ss.md
│   ├── sublime.md
│   ├── vim.md
│   ├── vnc.md
│   └── weechat.md
├── performance
│   ├── disk
│   │   └── note.md
│   ├── filesystem
│   │   └── note.md
│   ├── irq.md
│   ├── kernel_parameter.txt
│   ├── memory
│   │   └── note.md
│   ├── network
│   │   ├── note.md
│   │   ├── rps.md
│   │   └── rps.sh
│   └── taskset.md
├── protocol
│   ├── dns.md
│   ├── http
│   │   ├── custom_404.txt
│   │   ├── header.txt
│   │   ├── http.md
│   │   └── status.txt
│   ├── https.md
│   └── note.md
├── proxy
│   ├── haproxy
│   │   ├── note.md
│   │   └── topic.md
│   ├── lvs
│   │   ├── ipvsadm.txt
│   │   └── note.txt
│   └── note.md
├── security
│   ├── clamav.md
│   ├── csrf.md
│   ├── ddos.md
│   ├── jsonrpc.md
│   ├── jwt.md
│   └── xss.md
├── sniffer
│   ├── bro
│   │   ├── bro_note
│   │   ├── demo
│   │   │   ├── broClient.py
│   │   │   ├── event_t.bro
│   │   │   ├── func.bro
│   │   │   ├── interval.bro
│   │   │   ├── logging.bro
│   │   │   ├── main.bro
│   │   │   ├── new_conn.bro
│   │   │   ├── part1.bro
│   │   │   ├── part2.bro
│   │   │   ├── part3.bro
│   │   │   ├── part4.bro
│   │   │   ├── pattern-02.bro
│   │   │   ├── pattern.bro
│   │   │   ├── pingpong.bro
│   │   │   ├── record.bro
│   │   │   ├── reply.bro
│   │   │   ├── run.py
│   │   │   ├── ssl.bro
│   │   │   ├── start.sh
│   │   │   ├── table.bro
│   │   │   ├── var.bro
│   │   │   └── worker.bro
│   │   └── lang_note.md
│   ├── charles
│   │   └── note.md
│   ├── ethtool.md
│   ├── pfring.md
│   ├── tcpdump.md
│   ├── tcpreplay
│   │   └── note.md
│   └── wireshark
│       └── note.md
├── socket
│   ├── note.md
│   └── tcp1.jpg
├── software
│   ├── cmdbuild.md
│   ├── confluence.md
│   ├── elk
│   │   ├── api.md
│   │   ├── elk.txt
│   │   ├── esclient.py
│   │   ├── logstash.md
│   │   ├── move_unassigned_shard.sh
│   │   └── new-install.md
│   ├── jenkins
│   │   └── jenkins.txt
│   ├── jira.md
│   ├── nexus
│   │   └── install.md
│   └── solr
│       ├── data-config.xml
│       ├── db-data-config.xml
│       ├── schema.xml
│       ├── solr.txt
│       └── solrconfig.xml
├── sync
│   ├── english.txt
│   ├── get.txt
│   ├── goal.txt
│   ├── mac.md
│   ├── memo.txt
│   ├── music.txt
│   ├── todo.txt
│   └── work_note.txt
├── vcs
│   ├── git
│   │   ├── fork_workflow.md
│   │   ├── init.sh
│   │   └── memo.md
│   ├── gitlab
│   │   ├── gitlab.rb
│   │   ├── gitlab.txt
│   │   └── note.md
│   └── svn
│       ├── new.md
│       ├── note.md
│       └── svn.txt
├── virtualization
│   ├── docker
│   │   ├── assign_fixed_ip.sh
│   │   ├── build.md
│   │   ├── command.md
│   │   ├── daocloud.md
│   │   ├── docker-compose.yml
│   │   ├── docker_build_test
│   │   │   ├── Dockerfile
│   │   │   ├── entrypoint.sh
│   │   │   ├── readme.txt
│   │   │   └── test
│   │   │       └── test.md
│   │   ├── docker_file.md
│   │   ├── dockerd.md
│   │   ├── inspect.md
│   │   ├── run.md
│   │   ├── topic.md
│   │   └── work_note.md
│   ├── kvm
│   │   └── note.md
│   ├── openstack
│   │   ├── cloud-config.txt
│   │   ├── injection.txt
│   │   ├── memo.txt
│   │   ├── neutron-l3-agent
│   │   └── vxlan
│   └── vagrant
│       ├── note.txt
│       └── vagrant_pr.md
└── webserver
    ├── apache
    │   └── note.md
    ├── lighttpd
    │   └── lighttpd.conf
    ├── nginx
    │   ├── Nginx\ On\ rhel6.4.txt
    │   ├── Nginx.txt
    │   ├── forward_proxy.conf
    │   ├── https
    │   │   ├── elk.mmbang.net.conf
    │   │   ├── request.txt
    │   │   ├── server.crt
    │   │   ├── server.csr
    │   │   └── server.key
    │   ├── module.txt
    │   ├── nginx-mogilefs.conf
    │   ├── note.txt
    │   ├── rewrite.txt
    │   └── tengine.md
    └── note.md
```
