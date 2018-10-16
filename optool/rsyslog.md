# bash操作日志收集
## 1. 服务端
```
/etc/rsyslog.conf
     local7.*                                                /var/log/boot.log
     local3.*                                                /var/log/bash-history.log # 新增

/etc/logrotate.d/cmd_log
    /var/log/cmd.log {
        monthly
        rotate 12
        missingok
        notifempty
        create 600 root root
        copytruncate
    }

```
## 客户端
```
/etc/profile

    HISTTIMEFORMAT="%F %T "
    readonly PROMPT_COMMAND='{ cmd=$(history 1 | { read a b c d; echo "$d"; });msg=$(who am i |awk "{print \$2,\$5}");logger -d -n 192.168.1.170 -p local3.notice "$msg $USER $PWD # $cmd"; }'

```

# 登陆日志收集

## 1. 服务端
```
/etc/rsyslog.conf
     local7.*                                                /var/log/boot.log
     local4.*                                                /var/log/last-login.log # 新增

/etc/logrotate.d/login_log
    /var/log/last-login.log {
        monthly
        rotate 12
        missingok
        notifempty
        create 600 root root
        copytruncate
    }
```

## 2. 客户端
```
/etc/profile

    send_last_log(){
        last_log=$(last -n 1)
        logger -d -n 192.168.1.170 -p local4.notice "$last_log"

    }
    send_last_log
```
