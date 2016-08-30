
```
### 路由器设置
Router>enable
Router#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
Router(config)#interface GigabitEthernet0/1
Router(config-if)#no shutdown
Router(config-if)#exit
Router(config)#interface GigabitEthernet0/1.1
Router(config-subif)#
%LINK-5-CHANGED: Interface GigabitEthernet0/1.1, changed state to up
%LINEPROTO-5-UPDOWN: Line protocol on Interface GigabitEthernet0/1.1, changed state to up
Router(config-subif)#encapsulation dot1q 10
Router(config-subif)#ip address 192.168.0.254 255.255.255.0
Router(config-subif)#exit
Router(config)#interface GigabitEthernet0/1.2
Router(config-subif)#
%LINK-5-CHANGED: Interface GigabitEthernet0/1.2, changed state to up
%LINEPROTO-5-UPDOWN: Line protocol on Interface GigabitEthernet0/1.2, changed state to up
Router(config-subif)#encapsulation dot1q 20
Router(config-subif)#ip address 192.168.1.254 255.255.255.0
Router(config-subif)#exit

## SNAT配置
Router(config)#do clear ip nat trans * (clear all nat rules)

Router(config)#interface GigabitEthernet0/0
Router(config-if)#ip nat outside
Router(config-if)#exit
Router(config)#interface GigabitEthernet0/1.1
Router(config-subif)#ip nat inside
Router(config-subif)#exit
Router(config)#ip nat pool ovrld 10.0.0.101 10.0.0.101 netmask 255.255.0.0
Router(config)#exit
--------no-overload-------
ip nat pool no-overload 172.16.10.1 172.16.10.63 netmask 255.255.0.0
ip nat inside source list 1 pool no-overload 
--------------------------
Router(config)#access-list 1 permit 192.168.0.0 0.0.255.255
Router(config)#ip nat inside source list 1 pool ovrld overload
Router(config)#exit
Router#show ip nat translations
Pro  Inside global     Inside local       Outside local      Outside global
tcp 10.0.0.101:1025    192.168.0.1:1025   172.16.0.1:80      172.16.0.1:80

## DNAT
Router(config)#ip nat inside source static  tcp 192.168.0.1(内网机器) 80(内网端口) 10.0.0.101(外网地址) 80(外网端口)

## 静态路由配置
Router#clear ip route *

Router(config)#ip route 0.0.0.0 0.0.0.0 GigabitEthernet0/0 (默认路由)
##Router(config)#ip route 0.0.0.0 0.0.0.0 10.0.0.1 (默认路由)
Router(config)#ip route 192.168.0.0 255.255.255.0 10.0.0.1 
##Router(config)#ip route 192.168.0.0 255.255.255.0 GigabitEthernet0/0
Router(config)#exit
Router#show ip route
Codes: L - local, C - connected, S - static, R - RIP, M - mobile, B - BGP
       D - EIGRP, EX - EIGRP external, O - OSPF, IA - OSPF inter area
       N1 - OSPF NSSA external type 1, N2 - OSPF NSSA external type 2
       E1 - OSPF external type 1, E2 - OSPF external type 2, E - EGP
       i - IS-IS, L1 - IS-IS level-1, L2 - IS-IS level-2, ia - IS-IS inter area
       * - candidate default, U - per-user static route, o - ODR
       P - periodic downloaded static route

Gateway of last resort is not set

     10.0.0.0/8 is variably subnetted, 2 subnets, 2 masks
C       10.0.0.0/16 is directly connected, GigabitEthernet0/0
L       10.0.0.2/32 is directly connected, GigabitEthernet0/0
     172.16.0.0/16 is variably subnetted, 2 subnets, 2 masks
C       172.16.0.0/16 is directly connected, GigabitEthernet0/1.1
L       172.16.0.1/32 is directly connected, GigabitEthernet0/1.1
S    192.168.0.0/24 [1/0] via 10.0.0.1

Router(config)#ip route 192.168.1.0 255.255.255.0 10.0.0.1
Router(config)#exit
Router#show ip route static
S    192.168.0.0/24 [1/0] via 10.0.0.1
S    192.168.1.0/24 [1/0] via 10.0.0.1

## DHCP
----config dhcp service for vlan 100 --------
Router(config)#ip dhcp pool vlan_100
Router(dhcp-config)#network 192.168.0.0 255.255.255.0
Router(dhcp-config)#default-router 192.168.0.254
Router(dhcp-config)#dns-server 8.8.8.8
Router(dhcp-config)#exit
Router(config)#ip dhcp excluded-address 192.168.0.254 192.168.0.253

----config dhcp service for vlan 200 --------
Router(config)#ip dhcp pool vlan_200
Router(dhcp-config)#network 192.168.1.0 255.255.255.0
Router(dhcp-config)#default-router 192.168.1.254
Router(dhcp-config)#dns-server 8.8.8.8
Router(dhcp-config)#exit
Router(config)#ip dhcp excluded-address 192.168.1.254 192.168.1.253



## 端口镜像 SPAN: switch port analyzer
```
#local SPAN
    single switch
    switch stack
Local SPAN supports a SPAN session entirely within one switch; 
all source ports or source VLANs and destination ports are in the same switch 
or switch stack. Local SPAN copies traffic from one or more source ports in 
any VLAN or from one or more VLANs to a destination port for analysis
#remote SPAN
 
　　2900#conf t（进入配置状态）
　　2900(config)#int f0/18（对f0/18端口进行配置）
　　2900(config-if)#port monitor f 0/22（对f 0/22端口进行镜像）
　　2900(config-if)#end（结束配置）
　　2900C#sh port monitor （察看当前镜像端口及被镜像端口）
　　Monitor Port Port Being Monitored
　　--------------------- ---------------------
　　FastEthernet0/18 FastEthernet0/22


    2940#show monitor
　　2940(config)#monitor session 1 source interface fa 0/1 
　　2940(config)#monitor session 1 destination interface fa 0/4
```

