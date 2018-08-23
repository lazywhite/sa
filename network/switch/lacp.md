## 1. 环境
```
node1
    ens7f0(10Gb) 0/11
    ens7f1(10Gb) 0/23
node2
    ens7f0(10Gb) 0/12
    ens7f1(10Gb) 0/24

交换机:  RG-S6220-48XS4QXS 
```

## 2.1 服务器配置

```
### node1配置(node2参考node1)
ifcfg-bond0
    TYPE=Bond
    NAME=bond0
    DEVICE=bond0
    ONBOOT=yes
    BOOTPROTOCOL=none
    IPADDR=172.31.191.1
    PREFIX=24
    GATEWAY=172.31.191.254
    BONDING_MASTER=yes
    BONDING_OPTS="mode=4 miimon=100 lacp_rate=slow"

ifcfg-ens7f0
    TYPE=Ethernet
    NAME=ens7f0
    UUID=0ea98542-f827-4fab-afc0-0219726e8676
    DEVICE=ens7f0
    ONBOOT=yes
    BOOTPROTOCOL=none
    MASTER=bond0
    SLAVE=yes

ifcfg-ens7f1
    TYPE=Ethernet
    BOOTPROTO=none
    NAME=ens7f1
    DEVICE=ens7f1
    ONBOOT=yes
    BOOTPROTOCOL=none
    MASTER=bond0
    SLAVE=yes

```
## 2.2 交换机配置
```

conf t
    # 配置动态链路聚合
    interface TenGigabitEthernet 0/11
        port-group 101 mode active
        end
    interface TenGigabitEthernet 0/23
        port-group 101 mode active
        end

    interface TenGigabitEthernet 0/12
        port-group 102 mode active
        end
    interface TenGigabitEthernet 0/24
        port-group 102 mode active
        end
    # 设置聚合端口vlan
    interface aggregateport 101
        switchport mode access
        switchport access vlan 300
        end

    interface aggregateport 102
        switchport mode access
        switchport access vlan 300
        end

    aggregateport load-balance src-dst-ip # 全局设定ap负载均衡, 默认src-dst-mac
    end

show AggregatePort summary # 查看聚合端口
show lacp summary # 查看链路聚合信息
show aggregatePort load-balance # 查看AP负载均衡算法

交换机跟服务器间的LACP, mode是active, passive, priority均无需设定
交换机之间做LACP, 要注意两端的port priority和负责均衡算法

单连接最多占1个网卡带宽
服务器mode4 bond后, bond0及所有slave mac地址一样
```


