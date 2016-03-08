```
See the list of interfaces on which tcpdump can listen:
tcpdump -D

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

Display IP addresses and port numbers instead of domain and service names when capturing packets (note: on some systems you need to specify -nn to display port numbers):
tcpdump -n

Capture any packets where the destination host is 192.168.1.1. Display IP addresses and port numbers:
tcpdump -n dst host 192.168.1.1

Capture any packets where the source host is 192.168.1.1. Display IP addresses and port numbers:
tcpdump -n src host 192.168.1.1

Capture any packets where the source or destination host is 192.168.1.1. Display IP addresses and port numbers:
tcpdump -n host 192.168.1.1

Capture any packets where the destination network is 192.168.1.0/24. Display IP addresses and port numbers:
tcpdump -n dst net 192.168.1.0/24

Capture any packets where the source network is 192.168.1.0/24. Display IP addresses and port numbers:
tcpdump -n src net 192.168.1.0/24

Capture any packets where the source or destination network is 192.168.1.0/24. Display IP addresses and port numbers:
tcpdump -n net 192.168.1.0/24

Capture any packets where the destination port is 23. Display IP addresses and port numbers:
tcpdump -n dst port 23

Capture any packets where the destination port is is between 1 and 1023 inclusive. Display IP addresses and port numbers:
tcpdump -n dst portrange 1-1023

Capture only TCP packets where the destination port is is between 1 and 1023 inclusive. Display IP addresses and port numbers:
tcpdump -n tcp dst portrange 1-1023

Capture only UDP packets where the destination port is is between 1 and 1023 inclusive. Display IP addresses and port numbers:
tcpdump -n udp dst portrange 1-1023

Capture any packets with destination IP 192.168.1.1 and destination port 23. Display IP addresses and port numbers:
tcpdump -n "dst host 192.168.1.1 and dst port 23"

Capture any packets with destination IP 192.168.1.1 and destination port 80 or 443. Display IP addresses and port numbers:
tcpdump -n "dst host 192.168.1.1 and (dst port 80 or dst port 443)"

Capture any ICMP packets:
tcpdump -v icmp

Capture any ARP packets:
tcpdump -v arp

Capture either ICMP or ARP packets:
tcpdump -v "icmp or arp"

Capture any packets that are broadcast or multicast:
tcpdump -n "broadcast or multicast"

Capture 500 bytes of data for each packet rather than the default of 68 bytes:
tcpdump -s 500

Capture all bytes of data within the packet:
tcpdump -s 0
```
```
tcpdump -i any -s 0 -A -n -p port 3306 and src IP|grep -i -E 'SELECT|INSERT'

tcpdump [options] 过滤条件

tcpdump的语法：
tcpdump [options] [Protocol] [Direction] [Host(s)] [Value] [Logical Operations] [Other expression]

Protocol(协议):
Values(取值): ether, fddi, ip, arp, rarp, decnet, lat, sca, moprc, mopdl, tcp and udp.
If no protocol is specified, all the protocols are used. 

Direction(流向):
Values(取值): src, dst, src and dst, src or dst
If no source or destination is specified, the "src or dst" keywords are applied. 
For example, "host 10.2.2.2" is equivalent to "src or dst host 10.2.2.2".


Host(s)(主机):
Values(替代关键字): net, port, host, portrange.
If no host(s) is specified, the "host" keyword is used. 默认如果此段没有指定关键字，默认即host。
For example, "src 10.1.1.1" is equivalent to "src host 10.1.1.1". 


Logical Operations:
(1) AND 
and or &&
(2) OR 
or or ||
(3) EXCEPT 
not or !


常用选项：

-i any : Listen on all interfaces just to see if you're seeing any traffic.
-n : Don't resolve hostnames.（主机名）
-nn : Don't resolve hostnames or port names.（主机名和服务名）
-X : Show the packet's contents in both hex and ASCII.
-XX : Same as -X, but also shows the ethernet header.
-v, -vv, -vvv : Increase the amount of packet information you get back.
-c # : Only get x number of packets and then stop. 抓前n个包
-s : Define the snaplength (size) of the capture in bytes. Use -s0 to get everything, unless you are intentionally capturing less.
-S : Print absolute sequence numbers.
-e : Get the ethernet header as well.
-q : Show less protocol information.
-E : Decrypt IPSEC traffic by providing an encryption key.
-A ：Display Captured Packets in ASCII
-w /path/to/some_file : Capture the packets and write into a file 
-r /path/from/some_file : Reading the packets from a saved file 
-tttt : Capture packets with proper readable timestamp


ip host 172.16.100.1
ip src host 172.16.100.1
ip dst host 172.16.100.1
ip src and dst host 172.16.100.1

tcp src port 110



tcpdump -i eth0 -s0 -nn -XX tcp dst port 3306 and ip dst host 192.168.10.16 
```
