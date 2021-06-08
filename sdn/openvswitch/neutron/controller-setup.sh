ovs-vsctl add-br br-ex
ovs-vsctl add-br br-int
ovs-vsctl add-br br-tun

##ovs-vsctl add-port br-ex enp0s8 -- set interface enp0s8 type=internal
ovs-vsctl add-port br-ex enp0s8
ifconfig enp0s8 0
ifconfig br-ex 192.168.56.101/24

ovs-vsctl add-port br-ex ex-patch-int -- set interface ex-patch-int type=internal
ovs-vsctl add-port br-int int-patch-ex -- set interface int-patch-ex type=internal
ovs-vsctl set interface ex-patch-int type=patch options:peer=int-patch-ex
ovs-vsctl set interface int-patch-ex type=patch options:peer=ex-patch-int

ovs-vsctl add-port br-tun tun-patch-int -- set interface tun-patch-int type=internal
ovs-vsctl add-port br-int int-patch-tun -- set interface int-patch-tun type=internal
ovs-vsctl set interface tun-patch-int type=patch options:peer=int-patch-tun
ovs-vsctl set interface int-patch-tun type=patch options:peer=tun-patch-int


ovs-vsctl add-port br-tun vxlan0 -- set interface vxlan0 type=vxlan options:remote_ip=192.168.198.20
ovs-vsctl show
