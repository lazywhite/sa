## 软件防火墙
```
ipfilter (freebsd, solaris)
packetfilter (freebsd)
ipfirewall (mac, freebsd)

netfilter (linux)
    iptables
    ebtables
    firewalld

    netfilter是linux内核模块, 三者均是netfilter的front-end
    firewalld, nftables使用新版api与netfilter通信
    iptables-legacy使用旧版api通信, 最新的iptables也使用新版api
    ebtables规则仅应用于linux bridge
```

## 硬件防火墙
```
HillStone
Juniper
Cisco
```

