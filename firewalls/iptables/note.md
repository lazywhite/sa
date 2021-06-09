## version
```
iptables -V
    lagacy (最高1.8.3)
    nf_tables(centos8: ls -alh /usr/sbin/iptables -->  xtables-nft-multi)

    两者最大的不同是kernel mod api不同


centos8 netfilter模块是新版，旧版本的kube-proxy可能无法正常工作
```
## Intro
```
iptables 仅仅是netfilter模块的userspace frontend而已

PREROUTING
    route
        (in this host)INPUT->UserSpace->OUTPUT->POSTROUTING
        (not this host)FORWARD->POSTROUTING


table
    chain
        rule
            target

table
    iptables -L -n default table is Filter

    Filter:
        INPUT FORWARD OUTPUT
    NAT:
        PREROUTING INPUT OUTPUT POSTROUTING
    Mangle:
        PREROUTING INPUT  FORWARD  OUTPUT POSTROUTING
        一般用来修改包
    RAW:
        PREROUTING OUTPUT
        The raw table is mainly only used for one thing, and that is to set a mark on packets that they should not be handled by the connection tracking system

target
    ACCEPT
    DROP
    REJECT:  It sends a “connection reset” packet in case of TCP, or a “destination host unreachable” packet in case of UDP or ICMP.
    LOG: 记录进kernel log, 但会继续向下匹配
    RETURN
        INPUT --> EXAMPLE_CHAIN
        在EXAMPLE_CHAIN return会返回到INPUT继续匹配, 在INPUT return会应用Default Policy
    UserChain
    SNAT
    DNAT
    MASQUERADE
    MIRROR: 将src ip与dst ip对调，然后直接返回
    QUEUE: 将封包放入队列，由其它程序进行处理
    TOS:
    TTL
    MARK: 打标记，进行后续处理
        iptables -t mangle -A PREROUTING -p tcp --dport 22 -j MARK --set-mark 2


netfilter工作原理
    https://www.booleanworld.com/depth-guide-iptables-linux-firewall/
    数据流是按chain进行传递的，每个chain可能被多个table包含，会按顺序匹配各个table关于此chain定义的rule
```

## Usage
```
-A: append
-R: replace
-D: delete
-I [line]: insert

-N: new chain
-E: rename chain
-X: delete user defined chain
-P: policy
-F: flush , delete all rules
-Z: zero packet and byte counter

-t: table
-p: protocol  tcp/udp
-s: source ip
-d: dest ip
--sport: source port
--dport: dest port

-m: module


example
    iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    iptables -A INPUT -m conntrack --ctstate INVALID -j DROP

    iptables -L -n --line-numbers
    iptables -A INPUT -p tcp -m multiport --dports 22,5901 -s 59.45.175.0/24 -j DROP

    iptables -I INPUT 3 -p tcp -m tcp --dport 20 -j ACCEPT
    iptables -D INPUT 3

```

## Tips
```
NAT
    sysctl -w net.ipv4.ip_forward=1
    DNAT
        iptables -t nat -A PREROUTING -i eth0 -d 218.29.30.31 -p tcp --dport 80 -j DNAT --to-destination 192.168.1.7:80

    SNAT
        iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o eth0 -j SNAT --to-source 218.29.30.31
        或者
        iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o ppp0 -j MASQUERADE

    SNAT与MASQUERADE的区别
        MASQUERADE是用发送数据的网卡上的IP来替换源IP，对于IP不固定或有多张网卡的环境, 就得用MASQUERADE

ip_conntrack: table full, dropping packet
    (1) 加大 ip_conntrack_max 值
        vi /etc/sysctl.conf
        net.ipv4.ip_conntrack_max = 393216
        net.ipv4.netfilter.ip_conntrack_max = 393216

    (2): 降低 ip_conntrack timeout时间
    vi /etc/sysctl.conf
        net.ipv4.netfilter.ip_conntrack_tcp_timeout_established = 300
        net.ipv4.netfilter.ip_conntrack_tcp_timeout_time_wait = 120
        net.ipv4.netfilter.ip_conntrack_tcp_timeout_close_wait = 60
        net.ipv4.netfilter.ip_conntrack_tcp_timeout_fin_wait = 120

    (3): 加入raw规则, 不跟踪
        iptables -t raw -A PREROUTING -d 1.2.3.4 -p tcp --dport 80 -j NOTRACK
        iptables -A FORWARD -m state --state UNTRACKED -j ACCEPT

删除user-defined chain
    iptables -L -n --line-numbers
        Chain INPUT (policy ACCEPT)
        num  target     prot opt source               destination
        1    LIBVIRT_INP  all  --  0.0.0.0/0            0.0.0.0/0

        Chain LIBVIRT_INP (1 references)
        num  target     prot opt source               destination

    iptables -D INPUT 1  # chain LIBVIRT_INP reference become 0
    iptables -X LIBVIRT_INP

conntrack与stat模块
    iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
    iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

    state模块已废弃, 使用conntrack

ipset
    可以用multiport来操作一组port, 同样可以用一组ipset来操作一组ip
    # ipset list
    iptables -t nat -A POSTROUTING -m set --match-set kube-router-pod-subnets src -m set ! --match-set kube-router-pod-subnets dst -m set ! --match-set kube-router-node-ips dst -j MASQUERADE --random-fully

    ipset持久化
        ipset save > /etc/ipset.conf
        systemctl enable ipset.service

仅查看某条链的rule
    iptables -t nat -S PREROUTING
针对某张网卡
    iptables -A INPUT -i lo -j ACCEPT
端口不在列表就drop
    iptables -A INPUT -p tcp -m multiport ! --dports 22,80,443 -j DROP

limit模块, 无法针对每个src, 只能针对dst
    iptables -A INPUT -p tcp --dport 80 -m limit --limit 1/sec --limit-burst 1 -j ACCEPT

recent模块, 弥补limit缺陷
    iptables -A INPUT -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW -m recent --set --name SSHLIMIT --rsource
    iptables -A INPUT -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW -m recent --set --name SSHLIMIT --update --seconds 180 --hitcount 5 --name SSH --rsource -j DROP

owner模块，针对uid
    iptables -A OUTPUT -d 31.13.78.35 -m owner --uid-owner bobby -j DROP  # 用户名为bobby的被drop


addrtype
    iptables -A cali-POSTROUTING -o tunl0 -m comment --comment "cali:JHlpT-eSqR1TvyYm" -m addrtype ! --src-type LOCAL --limit-iface-out -m addrtype --src-type LOCAL -j MASQUERADE

    address type
        UNSPEC an unspecified address (i.e. 0.0.0.0)
        UNICAST an unicast address
        LOCAL a local address
        BROADCAST a broadcast address
        ANYCAST an anycast packet
        MULTICAST a multicast address
        BLACKHOLE a blackhole address
        UNREACHABLE an unreachable address
        PROHIBIT a prohibited address
        THROW FIXME
        NAT FIXME
        XRESOLVE

set
    iptables -A cali-pi-_pHTySCU__om1wJHIQqi -p tcp -m comment --comment "cali:xk4eV3PC6o8oerwT" -m set --match-set cali40s:NvVxuo5TpdJ9XcQNuWAN5Ec src -m multiport --dports 80 -j MARK --set-xmark 0x10000/0x10000


```
