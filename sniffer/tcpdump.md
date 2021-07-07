# tcmpdump [options] [expressions]
## 1. options
```
-i any : Listen on all interfaces just to see if you're seeing any traffic.
-n : Don't resolve hostnames.（主机名）
-nn : Don't resolve hostnames or port names.（主机名和服务名）
-X : Show the packet's contents in both hex and ASCII.
-XX : Same as -X, but also shows the ethernet header.
-v, -vv, -vvv : Increase the amount of packet information you get back.
-c: Only get x number of packets and then stop. 抓前n个包
-s : Define the snaplength (size) of the capture in bytes. Use -s0 to get everything, unless you are intentionally capturing less.
-S : Print absolute sequence numbers.
-e : Get the ethernet header as well.
-q : Show less protocol information.
-E : Decrypt IPSEC traffic by providing an encryption key.
-A ：Display Captured Packets in ASCII
-w /path/to/some_file : Capture the packets and write into a file 
-r /path/from/some_file : Reading the packets from a saved file 
-t: 不打印时间戳


See the list of interfaces on which tcpdump can listen:
tcpdump -D // discover interface

Listen on interface eth0:
tcpdump -i eth0

Listen on any available interface (cannot be done in promiscuous mode. Requires Linux kernel 2.2 or greater):
tcpdump -i any

Be verbose while capturing packets:
tcpdump -v

Be more verbose while capturing packets:
tcpdump -vv

Be very verbose while capturing packets:
tcpdump -vvv

Be verbose and print the data of each packet in both hex and ASCII, excluding the link level header:
tcpdump -v -X

Be verbose and print the data of each packet in both hex and ASCII, also including the link level header:
tcpdump -v -XX

Display IP addresses and port numbers instead of domain and service names when capturing packets
tcpdump -n
tcpdump -nn

Capture 500 bytes of data for each packet rather than the default of 68 bytes:
tcpdump -s 500

Capture all bytes of data within the packet:
tcpdump -s 0
```

## 2. expressions

```
[expression] [logical operation] [expression]

logical operations:
    and or &&
    or or ||
    not or !

expression:
    [protocol] [conditions]
conditions
    [condition] [logical operation] [condition]
protocol
    tcp
    ip
    ip6
    icmp
    broadcast
    multicast
    arp


ip
    dst host 192.168.1.1
    src host 192.168.1.1
    host 192.168.1.1
    dst net 192.168.1.0/24
    src net 192.168.1.0/24
    net 192.168.1.0/24
tcp
    dst port 23
    dst portrange 1-1023
    dst host 192.168.1.1 and dst port 23

udp
    dst portrange 1-1023

```

## read or write captured data
```
Be less verbose (than the default) while capturing packets:
tcpdump -q

Limit the capture to 100 packets:
tcpdump -c 100

Record the packet capture to a file called capture.cap:
tcpdump -w capture.cap

Record the packet capture to a file called capture.cap but display on-screen how many packets have been captured in real-time:
tcpdump -v -w capture.cap

Display the packets of a file called capture.cap:
tcpdump -r capture.cap

Display the packets using maximum detail of a file called capture.cap:
tcpdump -vvv -r capture.cap
```

## example
```
tcpdump -i any -s 0 -A -n -p port 3306 and src IP|grep -i -E 'SELECT|INSERT'
tcpdump -i bond0 -nvv icmp and ip host 10.66.71.245 # 抓跟某ip相关的icmp报
tcpdump -i eth0 -s0 -nn -XX tcp dst port 3306 and ip dst host 192.168.10.16 
tcpdump -n "broadcast or multicast"
tcpdump -v "icmp or arp"
tcpdump -nvvv -e -i bond0 icmp # -e 显示mac
```
