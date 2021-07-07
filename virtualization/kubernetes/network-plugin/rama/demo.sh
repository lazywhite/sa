source ./profile

# node1

:<<COMMENT
brctl addbr bond0
brctl addif enp0s9
brctl addif bond0 enp0s9
ip addr flush dev enp0s9
ifconfig bond0 192.168.198.30/24
# node2
ifconfig bond0 192.168.198.20/24

ifconfig bond0 up

ip link add link bond0 name bond0.${VID} type vlan id ${VID}
ifconfig bond0.${VID} up # 重要
brctl addbr rama${VID}
ifconfig rama${VID} up #重要, 否则同node的pod都无法互通
brctl addif rama${VID} bond0.${VID}


/etc/hosts
    192.168.1.1 pod1
    192.168.1.2 pod2


node网段跟pod网段不一样，则需要交换机支持, 在同一网段的话，bond0会响应pod的arp请求
COMMENT

create_ns pod1 192.168.1.1/16
create_ns pod2 192.168.1.2/16
add_if pod1 
add_if pod2


