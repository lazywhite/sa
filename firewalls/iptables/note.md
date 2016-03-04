## Introduction
iptables是netfilter项目的一部分
## Tables and Chains
```
Filter:
    INPUT FORWARD OUTPUT
NAT:
    PREROUTING FORWARD POSTROUTING
Mangle:
    PREROUTING OUTPUT
RAW:
    PREROUTING INPUT  FORWARD  OUTPUT POSTROUTING
SECURITY:
    
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


## LOG
# iptables -N logdrop

# iptables -A logdrop -m limit --limit 5/m --limit-burst 10 -j LOG   ##防止日志磁盘
# iptables -A logdrop -j DROP

iptables -A INPUT -m conntrack --ctstate INVALID -j logdrop
