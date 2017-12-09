## 安装特定版本
```
apt-get install package=version
```
## 清空source缓存
```
Hash Sum mismatch

rm -rf /var/lib/apt/lists/*
```

## 添加第三方源
```
/et/apt/sources.list.d/<third>.list
```


## 删除无依赖的包
```
apt-get autoremove
```

## 删除包和配置文件
```
apt-get purge <package>
```


## 查看某个文件属于哪个deb package
```
apt-get install apt-file
apt-file update
apt-file search <file-path>
```


## 启动脚本
```
#!/bin/sh

### BEGIN INIT INFO
# Provides:             eshop-server
# Required-Start:       $remote_fs $syslog
# Required-Stop:        $remote_fs $syslog
# Should-Start:         $network
# Should-Stop:          $network
# Default-Start:        2 3 4 5
# Default-Stop:         0 1 6
# Short-Description:    Enterprise Resource Management software
# Description:          Open ERP is a complete ERP and CRM software.
### END INIT INFO

PATH=/bin:/sbin:/usr/bin
DAEMON=/mnt/source/v6/eshop-server
NAME=eshop-server
DESC=eshop-server

# Specify the user name (Default: openerp).
USER=openerp

# Specify an alternate config file (Default: /etc/openerp-server.conf).
CONFIGFILE="/etc/openerp-server.conf"

# pidfile
PIDFILE=/var/run/$NAME.pid

# Additional options that are passed to the Daemon.
DAEMON_OPTS="-c $CONFIGFILE"

[ -x $DAEMON ] || exit 0
[ -f $CONFIGFILE ] || exit 0

checkpid() {
    [ -f $PIDFILE ] || return 1
    pid=`cat $PIDFILE`
    [ -d /proc/$pid ] && return 0
    return 1
}

case "${1}" in
        start)
                echo -n "Starting ${DESC}: "

                start-stop-daemon --start --quiet --pidfile ${PIDFILE} \
                        --chuid ${USER} --background --make-pidfile \
                        --exec ${DAEMON} -- ${DAEMON_OPTS}

                echo "${NAME}."
                ;;

        stop)
                echo -n "Stopping ${DESC}: "

                start-stop-daemon --stop --quiet --pidfile ${PIDFILE} \
                        --oknodo

                echo "${NAME}."
                ;;

        restart|force-reload)
                echo -n "Restarting ${DESC}: "

                start-stop-daemon --stop --quiet --pidfile ${PIDFILE} \
                        --oknodo

                sleep 1

                start-stop-daemon --start --quiet --pidfile ${PIDFILE} \
                        --chuid ${USER} --background --make-pidfile \
                        --exec ${DAEMON} -- ${DAEMON_OPTS}

                echo "${NAME}."
                ;;

        *)
                N=/etc/init.d/${NAME}
                echo "Usage: ${NAME} {start|stop|restart|force-reload}" >&2
                exit 1
                ;;
esac

exit 0
```
## disable service on startup
```
update-rc.d apache2 disable
```
## 网卡配置
```
/etc/network/interfaces.d/ifcfg-eth0
    auto eth0
    iface eth0 inet static
    address 192.168.0.117
    netmask 255.255.255.0
    gateway 192.168.0.1 
    network 192.168.0.0
    broadcast 192.168.0.255
```

## Iptables 
```
iptables-save
service iptables-persistent  save
```


## dpkg
```
dpkg -i /path/to/file.deb
dpkg -r <package>
dpkg -l|grep <package>
dpkg -L <package> # 列出文件列表
```
