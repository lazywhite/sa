## 1. create systemd unit file
[doc](https://www.freedesktop.org/software/systemd/man/systemd.service.html)  
  
```
/path/to/postfix.service


[Unit]
Description=Postfix Mail Transport Agent
After=syslog.target network.target
Conflicts=sendmail.service exim.service

[Service]
Type=forking
PIDFile=/var/spool/postfix/pid/master.pid
EnvironmentFile=-/etc/sysconfig/network
ExecStartPre=-/usr/libexec/postfix/aliasesdb          #pre-run process
ExecStartPre=-/usr/libexec/postfix/chroot-update
ExecStart=/usr/sbin/postfix start
ExecReload=/usr/sbin/postfix reload
ExecStop=/usr/sbin/postfix stop

[Install]
WantedBy=multi-user.target
```
## 2. add to systemd 

```
# ln -s /path/to/postfix.service  /etc/systemd/system/
# systemctl daemon-reload       # everytime service file is modified, run this 
                                # command to reflect change

# systemctl status <postfix>
# journalctl -xe                # view systemd log
# journalctl -u kube-proxy|less   # 查看特定服务的日志, 需要配合less才能完全显示
```
