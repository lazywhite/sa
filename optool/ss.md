## Doc
[ss 用法](http://www.ttlsa.com/linux-command/ss-replace-netstat/)
## netstat or ss
```
/proc/net/sockstat
netstat通过遍历proc来获取socket信息,效率较低
ss使用netlink与内核tcp_diag模块通信获取socket信息。

```
## ss
```
[root@localhost ~]# ss -h
Usage: ss [ OPTIONS ]
       ss [ OPTIONS ] [ FILTER ]
   -h, --help       this message
   -V, --version    output version information
   -n, --numeric    don't resolve service names
   -r, --resolve       resolve host names
   -a, --all        display all sockets
   -l, --listening  display listening sockets
   -o, --options       show timer information
   -e, --extended      show detailed socket information
   -m, --memory        show socket memory usage
   -p, --processes  show process using socket
   -i, --info       show internal TCP information
   -s, --summary    show socket usage summary

   -4, --ipv4          display only IP version 4 sockets
   -6, --ipv6          display only IP version 6 sockets
   -0, --packet display PACKET sockets
   -t, --tcp        display only TCP sockets
   -u, --udp        display only UDP sockets
   -d, --dccp       display only DCCP sockets
   -w, --raw        display only RAW sockets
   -x, --unix       display only Unix domain sockets
   -f, --family=FAMILY display sockets of type FAMILY

   -A, --query=QUERY, --socket=QUERY
       QUERY := {all|inet|tcp|udp|raw|unix|packet|netlink}[,QUERY]

   -D, --diag=FILE  Dump raw information about TCP sockets to FILE
   -F, --filter=FILE   read filter information from FILE
       FILTER := [ state TCP-STATE ] [ EXPRESSION ]



[root@localhost ~]# ss -s  #show socket usage summary
Total: 132 (kernel 165)
TCP:   9 (estab 1, closed 0, orphaned 0, synrecv 0, timewait 0/0), ports 5

Transport Total     IP        IPv6
*     165       -         -
RAW   0         0         0
UDP   8         5         3
TCP   9         5         4
INET      17        10        7
FRAG      0         0         0


[root@localhost ~]# ss -nl #list listening socket
State      Recv-Q Send-Q            Local Address:Port              Peer Address:Port
LISTEN     0      128                           *:49196                        *:*
LISTEN     0      128                          :::111                         :::*
LISTEN     0      128                           *:111                          *:*
LISTEN     0      128                          :::22                          :::*
LISTEN     0      128                           *:22                           *:*
LISTEN     0      100                         ::1:25                          :::*
LISTEN     0      100                   127.0.0.1:25                           *:*
LISTEN     0      128                          :::43963                       :::*
```

## 列出所有连接中的http的连接
```
ss -o state established '( dport = :http or sport = :http )'
ss -o state syn-recv|wc -l  判定是否为sync-flood
```
## 列出fin-wait的http连接
```
ss -o state fin-wait-1 '( dport = :http or sport = :http )'
```

## ss 常用socket状态
```
established
syn-sent
syn-recv
fin-wait-1
fin-wait-2
time-wait
closed
close-wait
last-ack
listen
closing
all : All of the above states
connected : All the states except for listen and closed
synchronized : All the connected states except for syn-sent
bucket : Show states, which are maintained as minisockets, i.e. time-wait and syn-recv.
big : Opposite to bucket state.
```
## 常用命令
```
ss src 120.33.31.1:80
ss src :22
ss sport eq :22


ss -n -o state established |grep 1433|wc -l # 查看mssql当前连接数
```


## doc
1. list tcp, udp, unix type : -t or -u or -x
2. -n disable hostname resolve to ip
3. -l show listening port
4. -p show process name/pid
5. -4/-6|-f inet/inet6 display only ipv4 or ipv6  



