## installation
```
yum -y install bind bind-utils
```

## 使用
```
/etc/named.conf
/var/named/net12.local.zone
/var/named/12.118.118.rev

# named-checkconf 

dig -t A www.baidu.com  # 正向解析
nslookup 192.168.12.12 # 反向解析
```
