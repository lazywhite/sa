## Introduction
iptables是netfilter项目的一部分
## Tables and Chains
```
Filter:
    INPUT FORWARD OUTPUT
NAT:
    PREROUTING OUTPUT POSTROUTING
Mangle:
    PREROUTING INPUT  FORWARD  OUTPUT POSTROUTING
    一般用来修改包
RAW:
    PREROUTING OUTPUT
    The raw table is mainly only used for one thing, and that is to set a mark on packets that they should not be handled by the connection tracking system
    
## Usage
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
action:
    REJECT
    ACCEPT
    DROP

-m: module
    conntrack
    limit

iptables -L -n --line-numbers
iptables -R INPUT(chain name) 1(line number) -p tcp --dport 22 -j accept

iptables -I INPUT 3 -p tcp -m tcp --dport 20 -j ACCEPT
iptables -D INPUT 3
iptables -t nat -D POSTROUTING 1

## NAT
iptables -t nat -A PREROUTING -d 202.202.202.2 -j DNAT --to-destination 192.168.0.102  
iptables -t nat -A POSTROUTING -d 192.168.0.102 -j SNAT --to 192.168.0.1 

iptables -t nat -A PREROUTING -i eth0 -d 218.29.30.31 -p tcp --dport 80 -j DNAT --to-destination 192.168.1.7:80
iptables -t nat -A PREROUTING -i eth0 -d 218.29.30.31 -p tcp --dport 2346 -j DNAT --to-destination 192.168.1.7:22


## LOG
# iptables -N logdrop

# iptables -A logdrop -m limit --limit 5/m --limit-burst 10 -j LOG   ##防止日志磁盘
# iptables -A logdrop -j DROP

iptables -A INPUT -m conntrack --ctstate INVALID -j logdrop


## Topic
###  ip_conntrack: table full, dropping packet  
```
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
```
  
