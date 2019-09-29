# bash操作日志收集
使用rsyslog服务器转发, 不直接使用logger, 避免低版本服务器logger没有-n选项问题  
## 1. 服务端
```
/etc/rsyslog.conf
    # 开启UDP, TCP监听
    $ModLoad imudp
    $UDPServerRun 514
    $ModLoad imtcp
    $InputTCPServerRun 514

    local7.*                                                /var/log/boot.log
    local3.*                                                /var/log/bash-history.log # 新增

/etc/logrotate.d/bash_history
    /var/log/bash-history.log {
        daily
        rotate 1060
        missingok
        notifempty
        create 644 root root
        copytruncate
    }

```
## 客户端
```
/etc/rsyslog.conf
    local3.* @@192.168.1.223:514

service rsyslog restart

/etc/profile

    HOSTIP=`ip a|grep 192.168|awk 'NR==1{print $2}'|awk -F/ '{print $1}'`
    HOSTIP=${HOSTIP:-`hostname`}

    LOGINIP=`who am i|awk '{print $NF}'|awk -F'(' '{print $2}'|awk -F')' '{print $1}'`


    HISTTIMEFORMAT="%F %T "
    readonly PROMPT_COMMAND='{ cmd=$(history 1 | { read a b c d; echo "$d"; });logger -p local3.notice "$LOGINIP $HOSTIP $USER $cmd"; }'


```

# 登陆日志收集

## 1. 服务端
```
/etc/rsyslog.conf
     local7.*                                                /var/log/boot.log
     local4.*                                                /var/log/last-login.log # 新增

systemctl restart rsyslog

/etc/logrotate.d/login_log
    /var/log/last-login.log {
        daily
        rotate 1060
        missingok
        notifempty
        create 644 root root
        copytruncate
    }
```

## 2. 客户端
```
/etc/rsyslog.conf
    local4.* @@192.168.1.223:514

service rsyslog restart

/etc/profile
    logger -p local4.notice $(who am i)
```
