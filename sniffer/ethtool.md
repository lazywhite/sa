##文档
[linux网络性能优化](http://www.ibm.com/developerworks/cn/linux/l-cn-network-pt/) 

### 网络优化思路
1. 发送路径
    TSO
    GSO
2. 转发路径
3. 接受路径  
    NAPI
    LRO
    GRO  
    
### GRE Generic Routing Encapsulation(隧道技术)

###NAPI (New api)

NAPI ("New API") is an extension to the device driver(software) packet processing framework, which is designed to improve the performance of high-speed networking
####Interrupt mitigation (降低中断请求次数)
High-speed networking can create thousands of interrupts per second, all of which tell the system something it already knew: it has lots of packets to process. NAPI allows drivers to run with (some) interrupts disabled during times of high traffic, with a corresponding decrease in system load.
####Packet throttling (过载情况下自动丢弃包)
When the system is overwhelmed and must drop packets, it's better if those packets are disposed of before much effort goes into processing them. NAPI-compliant drivers can often cause packets to be dropped in the network adaptor itself, before the kernel sees them at all.

### TSO (TCP Segmentation Offload）
硬件延缓分片技术, 属于LSO的一种  
### LSO: large segmentation offload  

### GSO (Generic Segmentation Offload)
软件延缓分片技术

### LRO (Large Receive Offload)
硬件层面的tcp包聚合, 集中提交功能
它通过将多个 TCP 数据聚合在一个 skb 结构，在稍后的某个时刻作为一个大数据包交付给上层的网络协议栈，以减少上层协议栈处理 skb 的开销，提高系统接收 TCP 数据包的能力
缺点: 破坏数据状态, 过于宽泛, 无法使用桥接功能, 只支持ipv4

### GRO(Generic Receive Offload)
GRO 的合并条件更加的严格和灵活，并且在设计时，就考虑支持所有的传输协议


### 结论
现在的网卡驱动，有 2 个功能需要使用，一是使用 NAPI 接口以使得中断缓和 (interrupt mitigation) ，以及简单的互斥，二是使用 GRO 的 NAPI 接口去传递数据包给网路协议栈。

## ethtool 
```
#开启/关闭混杂模式
ifconfig [interface] [-]promisc
```

```
#display standart information about NIC
[root@localhost warden]# ethtool eth1
Settings for eth1:
    Supported ports: [ TP ] #双绞线
    Supported link modes:   10baseT/Half 10baseT/Full
                            100baseT/Half 100baseT/Full
                            1000baseT/Full
    Supported pause frame use: No
    Supports auto-negotiation: Yes #自动协商工作模式
    Advertised link modes:  10baseT/Half 10baseT/Full
                            100baseT/Half 100baseT/Full
                            1000baseT/Full
    Advertised pause frame use: No
    Advertised auto-negotiation: Yes
    Speed: 1000Mb/s
    Duplex: Full #工作模式
    Port: Twisted Pair 
    PHYAD: 0 #physical address
    Transceiver: internal #收发器为外部或内部
    Auto-negotiation: on
    MDI-X: off (auto) #medium dependent interface , 1 to 2 
    Supports Wake-on: umbg 
        # supported wake-on-line mode
        #p: wake on physical activity
        #u: wake on unicast messages
        #m: wake on multicast messages
        #b: wake on broadcast messages
    Wake-on: d #disable wake-on-line and clear all settings
    Current message level: 0x00000007 (7) 
                   drv probe link
    #level of debugging message/data from driver
    #drv 0x0001  General driver status
    #name hexvalue description
    #probe   0x0002  Hardware probing
    #link    0x0004  Link stat
    Link detected: yes 
```
```
#网卡驱动信息
[root@localhost warden]# ethtool -i eth1 
driver: e1000  #驱动
version: 7.3.21-k8-NAPI
firmware-version: #固件
bus-info: 0000:00:08.0 # 总线
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: no
```

```
# query state of protocol offload and other features
[root@localhost .tmp]# ethtool -k eth1
Features for eth1:
rx-checksumming: off   #接包校验
tx-checksumming: off	#发包校验
    tx-checksum-ipv4: off	
    tx-checksum-unneeded: off
    tx-checksum-ip-generic: off
    tx-checksum-ipv6: off
    tx-checksum-fcoe-crc: off [fixed]
    tx-checksum-sctp: off [fixed]
scatter-gather: off    #分片 聚集功能
    tx-scatter-gather: off
    tx-scatter-gather-fraglist: off [fixed]
tcp-segmentation-offload: off
    tx-tcp-segmentation: off
    tx-tcp-ecn-segmentation: off
    tx-tcp6-segmentation: off
udp-fragmentation-offload: off [fixed]
generic-segmentation-offload: off
generic-receive-offload: off
large-receive-offload: off [fixed]
rx-vlan-offload: on [fixed]
tx-vlan-offload: on [fixed]
ntuple-filters: off [fixed]
receive-hashing: off [fixed]
highdma: off [fixed]    #direct memory access
rx-vlan-filter: on [fixed]
vlan-challenged: off [fixed]
tx-lockless: off [fixed]
netns-local: off [fixed]
tx-gso-robust: off [fixed]
tx-fcoe-segmentation: off [fixed]
tx-gre-segmentation: off [fixed]    
tx-udp_tnl-segmentation: off [fixed]
fcoe-mtu: off [fixed]   #fiber channel over ethernet 
loopback: off [fixed]

```

```
ethtool -K $1 rx off
ethtool -K $1 tx off
ethtool -K $1 sg off
ethtool -K $1 tso off
ethtool -K $1 ufo off
ethtool -K $1 gso off
ethtool -K $1 gro off
ethtool -K $1 lro off

rx on|off
Specifies whether RX checksumming should be enabled.
tx on|off
Specifies whether TX checksumming should be enabled.
sg on|off
Specifies whether scatter-gather should be enabled.
tso on|off
Specifies whether TCP segmentation offload should be enabled.
ufo on|off
Specifies whether UDP fragmentation offload should be enabled
gso on|off
Specifies whether generic segmentation offload should be enabled
gro on|off
Specifies whether generic receive offload should be enabled
lro on|off
Specifies whether large receive offload should be enabled
rxvlan on|off
Specifies whether RX VLAN acceleration should be enabled
txvlan on|off
Specifies whether TX VLAN acceleration should be enabled
ntuple on|off
Specifies whether Rx ntuple filters and actions should be enabled
rxhash on|off
Specifies whether receive hashing offload should be enabled
```
```
# make corresponsed LED blink
[root@localhost]# ethtool -p eth1   
```
