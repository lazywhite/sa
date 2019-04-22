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


