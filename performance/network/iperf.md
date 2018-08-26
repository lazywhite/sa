yum -y install iperf3

node1:
    iperf3 -S -4 --bind 192.168.0.1  # default port 5201
node2:
    iperf3 -Z -4 -C 192.168.0.1  -t 20 # default 10s
