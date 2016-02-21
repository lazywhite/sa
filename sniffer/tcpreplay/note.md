##Install guide
1. install libpcap manually , libpcap-devel of yum repo is depracated
2. compile and install tcpreplay


## commands
tcprewrite --infile=http_out.pcap --outfile=1.pcap --dstipmap=0.0.0.0/0:192.168.222.5 --enet-dmac=08:00:27:38:2F:8D
tcprewrite --infile=1.pcap --outfile=2.pcap --srcipmap=0.0.0.0/0:192.168.222.1 --enet-smac=0a:00:27:00:00:01
tcprewrite --infile 2.pcap --outfile 3.pcap --portmap=8888:80
tcprewrite --infile=3.pcap --outfile=final.pcap --fixcsum

tcpreplay --topspeed --loop=10 --intf1=eth1 /path/to/file.pcap

