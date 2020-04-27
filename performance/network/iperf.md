yum -y install iperf3

node1:
    iperf3 -s -4 --bind 192.168.0.1  # default port 5201
node2:
    iperf3 -Z -4 -c 192.168.0.1  -t 20 # default 10s, client send, server recv, upload bandwidth
    iperf3 -Z -4 -c 192.168.0.1  -R -t 20 # default 10s, download bandwidth
