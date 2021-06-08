## disable service on startup
```
update-rc.d apache2 disable
```
## 网卡配置
```
18.04之后使用netplan, 参考netplan.txt
/etc/network/interfaces.d/ifcfg-eth0
    auto eth0
    iface eth0 inet static
    address 192.168.0.117
    netmask 255.255.255.0
    gateway 192.168.0.1 
```

## Iptables 
```
iptables-save
service iptables-persistent  save
```

## fusermount not found
```
apt-get install -y fuse
```


## timedatectl
```
timedatectl set-ntp on
timedatectl set-timezone Asia/Shanghai
timedatectl set-local-rtc 1 --adjust-system-clock
timedatectl 
```

## localectl
```
/var/lib/locales/supported.d/local # create
    en_US.UTF-8 UTF-8
    zh_CN.UTF-8 UTF-8
    zh_CN.GBK GBK
    zh_CN GB2312
 
# locale-gen
#localectl set-local zh_CN.UTF-8

/root/.bashrc
    export LC_ALL=zh_CN.UTF-8
    
```
