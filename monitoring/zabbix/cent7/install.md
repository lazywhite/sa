# 环境信息
```
zabbix版本: 3.4

节点IP及OS: 
    118.118.12.17 ubuntu-16.04
    118.118.12.16 ubuntu-14.04
    118.118.12.15 centos-6.5
    118.118.12.14 centos-7
    118.118.12.13 centos-7 (代理节点)
    192.168.33.128 centos-7 (master节点)
    

部署架构: master运行zabbix_master及zabbix_web, 其余被监控节点通过proxy节点进行代理

准备工作: 确保集群时间同步

```
http://192.168.33.128/zabbix/  
登录信息: admin/zabbix  


# 一. zabbix-server
## 1.1 安装流程
```
## 添加阿里云及epel源
rm -rf /etc/yum.repos.d/*
curl  http://mirrors.aliyun.com/repo/Centos-7.repo >> /etc/yum.repos.d/aliyun.repo
rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

## 安装依赖包
yum install gcc  libxml2-devel  unixODBC-devel net-snmp-devel libcurl-devel libssh2-devel OpenIPMI-devel openssl-devel mysql++-devel mariadb mariadb-server libevent-devel pcre-devel

## 编译安装
./configure --prefix=/usr/local/zabbix --enable-server --enable-agent --with-mysql --with-net-snmp --with-libcurl --with-libxml2 --with-unixodbc --with-ssh2 --with-openipmi --with-openssl

make install 


## 数据库配置
systemctl start mariadb
mysql_secure_installation

/etc/my.cnf
    skip-name-resolve

create database zabbix charset utf8;
grant all on zabbix.* to 'zbx_user'@'%' identified by 'zbx_pw';

## 导入表结构及数据
cd database/mysql
mysql -uzbx_user -p'zbx_pw' zabbix < schema.sql
mysql -uzbx_user -p'zbx_pw' zabbix < images.sql
mysql -uzbx_user -p'zbx_pw' zabbix < data.sql

## 生成zabbix系统用户
useradd -M zabbix -s /sbin/nologin


## 修改server配置文件, 参考1.2.1
## 添加server服务启动脚本, 参考1.2.2
## 启动服务
service zabbix_server start


## 修改agent配置文件, 参考1.3.1
## 添加agent服务启动脚本, 参考1.3.2
## 启动服务
service zabbix_agent start
```

### 1.2.1 zabbix-server配置文件
```
/usr/local/zabbix/etc/zabbix_server.conf


ListenPort=10051
LogFile=/tmp/zabbix_server.log
DBHost=127.0.0.1
DBName=zabbix
DBUser=zbx_user
DBPassword=zbx_pw
DBPort=3306
ListenIP=0.0.0.0
Timeout=4
LogSlowQueries=3000
Include=/usr/local/zabbix/etc/zabbix_server.conf.d/*.conf

## proxy被动模式配置
StartProxyPollers=5
ProxyConfigFrequency=30
ProxyDataFrequency=1

## discovery配置
StartDiscoverers=10


## IPMI监控
StartIPMIPollers=10

#DebugLevel=4

CacheSize=128M
```

### 1.2.2 zabbix-server服务启动脚本
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

### 1.3.1 zabbix-agent配置文件
```
/usr/local/zabbix/etc/zabbix_agent.conf


LogFile=/tmp/zabbix_agentd.log
EnableRemoteCommands=1
Server=127.0.0.1,192.168.33.128  #zabbix_master或者zabbix_proxy的IP
ListenPort=10050
ListenIP=0.0.0.0
ServerActive=192.168.33.128
Hostname=118.118.12.13
HostMetadataItem=system.uname
AllowRoot=0
User=zabbix
Include=/usr/local/zabbix/etc/zabbix_agentd.conf.d/*.conf
```
### 1.3.2 zabbix-agent服务启动脚本
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


# 二. zabbix-web
## 2.1 整体流程
```
# 安装php56源
rpm -ivh http://mirror.webtatic.com/yum/el7/webtatic-release.rpm

# 安装依赖包
yum -y install php56w-cli php56w-pdo php56w-bcmath php56w php56w-mysql php56w-gd php56w-xml php56w-common php56w-mbstring php56w-devel php56w-pear httpd


# 拷贝web代码
cp -ar frontend/php   /var/www/html/zabbix
chown -R apache:apache /var/www/html


# 中文字体设置
cp msyh.ttf   /var/www/html/zabbix/fonts/

./include/defines.inc.php
	 define('ZBX_FONTPATH', realpath('fonts')); 
	 define('ZBX_GRAPH_FONT_NAME', 'msyh'); 
	 define('ZBX_FONT_NAME', 'msyh');


# 中文支持
yum -y install gettext 
localedef -i zh_CN -c -f UTF-8 zh_CN.UTF-8
cd /var/www/html/zabbix/locale; ./make_mo.sh 

# 修改php配置, 参考2.2
# 启动httpd服务
systemctl start httpd

## 访问http:/192.168.33.128/zabbix 
## 配置完毕自动生成conf/zabbix.conf.php
## 默认登录用户 admin/zabbix
## User Profile-->Language修改显示语言

```

## 2.2 更改php配置文件

```
/etc/php.ini
    post_max_size=16M
    max_execution_time=300
    max_input_time=300
    date.timezone=Asia/Shanghai
    always_populate_raw_post_data=-1
```


# 三. zabbix-proxy
## 3.1 整体流程
```
## 安装依赖包
yum -y install mariadb mariadb-server mariadb-devel net-snmp-devel libssh2-devel OpenIPMI-devel libevent-devel

## 编译安装
./configure --prefix=/usr/local/zabbix --enable-proxy --enable-agent --with-net-snmp --with-mysql --with-ssh2 --with-openipmi


## 数据库配置
systemctl start mariadb
mysql_secure_installation

/etc/my.cnf
    skip-name-resolve
systemctl restart mariadb

create database zabbix_proxy charset utf8;
grant all on zabbix_proxy.* to 'zbx_user'@'%' identified by 'zbx_pw';
mysql -uzbx_user -pzbx_pw zabbix_proxy < database/mysql/schema.sql

## 添加系统用户
useradd -M zabbix -s /sbin/nologin


##  proxy配置文件, 参考3.2
##  proxy启动脚本, 参考3.3

## 启动proxy进程
```
service zabbix_proxy start
```
## 3.2 proxy配置文件
```
ProxyMode=1
Server=192.168.33.128
Hostname=118.118.12.15
ListenPort=30000
LogFile=/tmp/zabbix_proxy.log
DBHost=127.0.0.1
DBName=zabbix_proxy
DBUser=zbx_user
DBPassword=zbx_pw
HeartbeatFrequency=60
ConfigFrequency=300
DataSenderFrequency=10
Timeout=4
LogSlowQueries=3000
AllowRoot=0
User=zabbix

## IPMI监控
StartIPMIPollers=10

```


## 3.3 proxy启动脚本
```
#!/bin/bash
#
# zabbix_proxy         This shell script takes care of starting
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
ZABBIX_NAME="zabbix_proxy"
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

# 四. zabbix-agent
## 4.1 整体流程
```
# 配置软件源
# 安装依赖包
yum -y install pcre-devel ## RHEL

# apt-get install pcre-devel

# 编译安装
./configure --prefix=/usr/local/zabbix --enable-agent
make install

# agent配置文件, 参考1.3.1
# 服务启动脚本, 参考1.3.2
```
