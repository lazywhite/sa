### addr
```
ip addr flush dev eth0
ip addr add 192.168.128.5/24 dev br0
```

### link
```
ip link set br0 up

# vlan
    ip link add link eth0 name eth0.8 type vlan id 8 #eth0必须是已存在的设备
    ip -d link show eth0.8
    ip link delete eth0.8
```


### netns
```
ip netns add <test>  
    # /var/run/netns/test
    # /proc/<pid>/net/ns
ip netns exec <pid> ip link set dev <> name "eth0" # 重命名网卡
```


### route
```
# 停止并删除NetworkManager !!!

添加路由
ip route add 192.168.0.0/24 via 192.168.0.1
删除路由
ip route del 192.168.0.0/24 via 192.168.0.1

增加默认路由
ip route add default via 192.168.0.1 dev eth0

查看路由信息
ip route

测试路由规则
ip route get 8.8.8.8 from 172.31.232.106

持久化
    /sbin/ifup-local
		#!/bin/bash
		if [[ "$1" == "enp3s0f0" ]];then
			ip rule add from 172.31.232.0/24 table 100
			ip route add default via 172.31.232.254 dev enp3s0f0 table 100
		fi

案例
    网络规定192.168.1.10可以出外网, 某台机器eth1已有ip 192.168.1.2
    1. 绑定ip到虚拟网卡
        ifconfig eth1:2 192.168.1.10/24
    2. 更改默认路由
        route del default gw 192.168.1.254 eth1
        route add default gw 192.168.1.254 eth1:2
    3. 持久化
```

### bridge
```
# ip link add br0 type bridge
# ip link set eth0 master br0
# ip link set eth0 nomaster
```

### bond
```
ip link add bond1 type bond miimon 100 mode active-backup
ip link set eth0 master bond1
ip link set eth1 master bond1
```

### team
```
# teamd -o -n -U -d -t team0 -c '{"runner": {"name": "activebackup"},"link_watch": {"name": "ethtool"}}'
# ip link set eth0 down
# ip link set eth1 down
# teamdctl team0 port add eth0
# teamdctl team0 port add eth1
```

### macvlan
```
# ip link add macvlan1 link eth0 type macvlan mode bridge
# ip link add macvlan2 link eth0 type macvlan mode bridge
# ip netns add net1
# ip netns add net2
# ip link set macvlan1 netns net1
# ip link set macvlan2 netns net2
```

### other
```
scope
blackhole
proto
metric
```
