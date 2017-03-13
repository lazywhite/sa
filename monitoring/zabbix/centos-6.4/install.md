## 1.1 zabbix-server
```
## enable epel.repo, ustc.repo

cd zabbix-3.0.3
yum install gcc  libxml2-devel  unixODBC-devel net-snmp-devel libcurl-devel libssh2-devel OpenIPMI-devel openssl-devel mysql++-devel mysql mysql-server
./configure --prefix=/usr/local --enable-server --enable-agent --with-mysql --with-net-snmp --with-libcurl --with-libxml2 --with-unixodbc --with-ssh2 --with-openipmi --with-openssl
make install 


/etc/init.d/mysqld start
mysql_secure_installation

create database zabbix charset utf8;
grant all on zabbix.* to zabbix_user@'%' identified by 'zabbix_pwd';

cd database/mysql
mysql -uzabbix_user -p'zabbix_pwd' zabbix < schema.sql
mysql -uzabbix_user -p'zabbix_pwd' zabbix < images.sql
mysql -uzabbix_user -p'zabbix_pwd' zabbix < data.sql

```
## 1.2 /usr/local/zabbix/etc/zabbix_server.conf
```
ListenPort=10051
LogFile=/tmp/zabbix_server.log
DBHost=localhost
DBName=zabbix
DBUser=zabbix_user
DBPassword=zabbix_pwd
DBPort=3306
ListenIP=0.0.0.0
Timeout=4
LogSlowQueries=3000
Include=/usr/local/zabbix/etc/zabbix_server.conf.d/*.conf
```

## 1.3 zabbix-server upstart
```
#!/bin/bash
#
# zabbix_server         This shell script takes care of starting
#                       and stopping Zabbix Server daemon
#
# chkconfig:            35 96 14
# description:          ZABBIX is an all-in-one 24x7 monitoring system
#

# Source function library.
. /etc/rc.d/init.d/functions

# Source networking configuration.
. /etc/sysconfig/network

# Check that networking is up.
[ ${NETWORKING} = "no" ] && exit 0


RETVAL=0

# Setting up configuration
ZABBIX_NAME="zabbix_server"
ZABBIX_CONF="/usr/local/zabbix/etc/$ZABBIX_NAME.conf"
#LogFIle=/tmp/zabbix_server.log

if [ ! -f $ZABBIX_CONF ]
then
    echo "$ZABBIX_NAME configuration file $ZABBIX_CONF does not exist. "
    exit 3
fi

# Source config file to load configuration
. $ZABBIX_CONF

ZABBIX_USER="zabbix"
ZABBIX_BIND="/usr/local/zabbix/sbin"
ZABBIX_BINF="$ZABBIX_BIND/$ZABBIX_NAME"

if [ ! -x $ZABBIX_BINF ] ; then
    echo "$ZABBIX_BINF not installed! "
    exit 4
fi


# Functions
runcheck() {
    [ ! -f $ZABBIX_PIDF ] && return 0
    PID=`cat $ZABBIX_PIDF`
    checkpid $PID
    [ $? -ne 0 ] && rm -f $ZABBIX_PIDF
}


start() {
    # Start daemons.
    echo -n $"Starting $ZABBIX_NAME: "
    #runcheck
    daemon --user $ZABBIX_USER $ZABBIX_BINF -c $ZABBIX_CONF
    RETVAL=$?
    [ $RETVAL -eq 0 ] && touch /var/lock/subsys/$ZABBIX_NAME
    return $RETVAL
}

stop() {
    # Stop daemons.
    echo -n $"Shutting down $ZABBIX_NAME: "
    killproc $ZABBIX_NAME
    RETVAL=$?
    echo
    [ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/$ZABBIX_NAME
    return $RETVAL
}

# See how we were called.
case "$1" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  restart|reload)
        stop
        usleep 1000000
        start
        RETVAL=$?
        ;;
  condrestart)
        if [ -f /var/lock/subsys/$ZABBIX_NAME ]; then
            stop
            usleep 1000000
            start
            RETVAL=$?
        fi
        ;;
  status)
        status $ZABBIX_NAME
        RETVAL=$?
        ;;
  *)
        echo $"Usage: $0 {start|stop|restart|condrestart|status}"
        exit 1
esac

exit $RETVAL
```

## 2.1 zabbix-agent
```
./configure --prefix=/usr/local/zabbix --enable-agent
```
## 2.2 /usr/local/zabbix/etc/zabbix_agent.conf
```
LogFile=/tmp/zabbix_agentd.log
EnableRemoteCommands=1
Server=127.0.0.1,10.90.20.6
ListenPort=10050
ListenIP=0.0.0.0
ServerActive=10.90.20.6
Hostname=Zabbix_Server
HostnameItem=system.hostname
AllowRoot=0
User=zabbix
Include=/usr/local/zabbix/etc/zabbix_agentd.conf.d/*.conf
```
## 2.3 zabbix-agent upstart 
```
#!/bin/bash
#
# zabbix_agentd         This shell script takes care of starting
#                       and stopping Zabbix Agent daemon
#
# chkconfig:            35 95 15
# description:          ZABBIX is an all-in-one 24x7 monitoring system
#

# Source function library.
. /etc/rc.d/init.d/functions

# Source networking configuration.
. /etc/sysconfig/network

# Check that networking is up.
[ ${NETWORKING} = "no" ] && exit 0


RETVAL=0

# Setting up configuration
ZABBIX_NAME="zabbix_agentd"
ZABBIX_CONF="/usr/local/zabbix/etc/$ZABBIX_NAME.conf"

if [ ! -f $ZABBIX_CONF ]
then
    echo "$ZABBIX_NAME configuration file $ZABBIX_CONF does not exist. "
    exit 3
fi

# Source config file to load configuration
. $ZABBIX_CONF

ZABBIX_USER="zabbix"
ZABBIX_BIND="/usr/local/zabbix/sbin"
ZABBIX_BINF="$ZABBIX_BIND/$ZABBIX_NAME"

if [ ! -x $ZABBIX_BINF ] ; then
    echo "$ZABBIX_BINF not installed! "
    exit 4
fi

start() {
    # Start daemons.
    echo -n $"Starting $ZABBIX_NAME: "
    daemon --user $ZABBIX_USER $ZABBIX_BINF -c $ZABBIX_CONF
    RETVAL=$?
    [ $RETVAL -eq 0 ] && touch /var/lock/subsys/$ZABBIX_NAME
    return $RETVAL
}

stop() {
    # Stop daemons.
    echo -n $"Shutting down $ZABBIX_NAME: "
    killproc $ZABBIX_NAME
    RETVAL=$?
    echo
    [ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/$ZABBIX_NAME
    return $RETVAL
}

# See how we were called.
case "$1" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  restart|reload)
        stop
        usleep 1000000
        start
        RETVAL=$?
        ;;
  condrestart)
        if [ -f /var/lock/subsys/$ZABBIX_NAME ]; then
            stop
            usleep 1000000
            start
            RETVAL=$?
        fi
        ;;
  status)
        status $ZABBIX_NAME
        RETVAL=$?
        ;;
  *)
        echo $"Usage: $0 {start|stop|restart|condrestart|status}"
        exit 1
esac

exit $RETVAL
```

## 3.1 zabbix-proxy
```
./configure --prefix=/usr/local/zabbix_proxy --enable-proxy --with-net-snmp --with-mysql --with-ssh2
mysql -uzabbix_user -pzabbix_pwd zabbix < schema.sql  ## only need this
```
## 3.2 /usr/local/zabbix/etc/zabbix_proxy.conf
```
```
## 4.1 zabbix-web
```
requirements: php-5.4 or above
rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
yum -y install php56w-cli php56w-pdo php56w-bcmath php56w php56w-mysql php56w-gd php56w-xml php56w-common php56w-mbstring php56w-devel php56w-pear
```
## 4.2
```
/etc/php.ini
    post_max_size=16M
    max_execution_time=300
    max_input_time=300
    date.timezone=Asia/Shanghai
    always_populate_raw_post_data=-1
```
## 4.3 enable multi language support
```
yum -y install gettext 
locale-gen #set zh_CN as locale
cd /var/www/html/zabbix/locale; ./make_mo.sh 

cp -ar frontend/php   /var/www/html/zabbix
chown -R apache:apache /var/www/html

cp msyh.ttf   /var/www/html/zabbix/fonts/
./include/defines.inc.php
	define('ZBX_FONTPATH',              realpath('fonts'));     	define('ZBX_GRAPH_FONT_NAME',       'msyh'); // font file name
	define('ZBX_FONT_NAME', 'msyh');

Configure -- User -- Admin -- Language --> Chinese(zh_CN)
http://localhost/zabbix/setup.php # generate zabbix.conf.php
```
## 4.4  zabbix.conf.php
```
<?php
// Zabbix GUI configuration file.
global $DB;

$DB['TYPE']     = 'MYSQL';
$DB['SERVER']   = 'localhost';
$DB['PORT']     = '3306';
$DB['DATABASE'] = 'zabbix';
$DB['USER']     = 'zabbix_user';
$DB['PASSWORD'] = 'zabbix_pwd';

// Schema name. Used for IBM DB2 and PostgreSQL.
$DB['SCHEMA'] = '';

$ZBX_SERVER      = 'localhost';
$ZBX_SERVER_PORT = '10051';
$ZBX_SERVER_NAME = 'zabbix server';

$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
```
## 5.1 install java-gateway
```
./configure --prefix=/usr/local --enable-java
make install
```

## 5.2 /usr/local/sbin/zabbix_java
```
    startup.sh
    shutdown.sh
    settings.sh
    lib
        logback.xml
```
## 5.3 configure 
```
/usr/local/etc/zabbix_server.conf:
    JavaGateway=<ip of java_gateway>
    JavaGatewayPort=10052
    StartJavaPoller=5
    
# restart zabbix_server 
```

## 5.4 start java application
```
1. /usr/local/tomcat-7.0.65/bin/catalina.sh 
    CATALINA_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=12345"

bin/catalina.sh start
2. configure host, add JMX interface
3. link Template JMX Generic, Template JMX Tomcat
4. item type : JMX agent proxy
```
## 6.1 Alert
```
名称: send_sms
类型: 脚本
脚本名称: send_sms.py
脚本参数: 
    {ALERT.SENDTO}
    {ALERT.SUBJECT}
    {ALERT.MESSAGE}
```

## 6.2 default message
```
Subject: {TRIGGER.STATUS}: {TRIGGER.NAME}

Message: 
    Trigger status: {TRIGGER.STATUS}
    Trigger severity: {TRIGGER.SEVERITY}
    Event Datetime: {EVENT.DATE} {EVENT.TIME}

    Item values:

    {ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}


    Original event ID: {EVENT.ID}
```

## Problem
```
[root@demo~]# zabbix_get -s host -k system.uptime
zabbix_get [8967]: Check access restrictions in Zabbix agent configuration

    check logfile of zabbix agent, connection from "114.55.57.153" rejected, add ip to "Server="  list
```



