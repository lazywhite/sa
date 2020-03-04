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


## 时间同步
```
https://wiki.archlinux.org/index.php/Systemd-timesyncd_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
使用timesyncd, 不是ntpd
timedatectl set-ntp on
timedatectl 
```
