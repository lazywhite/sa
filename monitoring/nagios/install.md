## 1. 架构规划
```
server: 10.0.0.1
client: 10.0.0.2
```
## 1.1 nagios server
```
yum -y install nagios httpd nagios-plugins-all

/etc/nagios/nagios.cfg
    cfg_dir=/etc/nagios/objects/servers


systemctl start nagios 

# 1. 获取登陆密码
/etc/http/conf.d/nagios.conf
    /etc/nagios/passwd # 默认认证文件
    htpasswd -c -b  /etc/nagios/passwd nagiosadmin # 修改密码

systemctl restart httpd 

http://ip/nagios  # 如果不使用nagiosadmin登陆, 可能有问题2.1
```



## 1.2 linux server
```
yum -y install nrpe

/etc/nagios/nrpe.cfg
    allowed_hosts=127.0.0.1,10.0.0.1

systemctl start nrpe  # 默认监听5666端口

# 验证
(server side) #/usr/lib64/nagios/plugins/check_nrpe -H 10.0.0.2 -p 5666 -u -t 60 -c check_load 
```







## 2.问题

```
2.1 It appears as though you do not have permission to view information for any of the service
 

是因为cgi.cfg 的用户名不与 htpasswd 用户名匹配，出于安全考虑并不与显示监控

修改 nagios/etc/cgi.cfg 文件即可

题主用户名为nagios，在句子尾部即可
authorized_for_system_information=nagiosadmin,nagios
authorized_for_configuration_information=nagiosadmin,nagios
authorized_for_system_commands=nagiosadmin,nagios
authorized_for_all_services=nagiosadmin,nagios
authorized_for_all_hosts=nagiosadmin,nagios
authorized_for_all_service_commands=nagiosadmin,nagios
authorized_for_all_host_commands=nagiosadmin,nagios

```

