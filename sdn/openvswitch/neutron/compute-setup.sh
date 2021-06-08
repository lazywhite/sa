ovs-vsctl add-br br-int
ovs-vsctl add-br br-tun

ovs-vsctl add-port br-tun tun-patch-int -- set interface tun-patch-int type=internal
ovs-vsctl add-port br-int int-patch-tun -- set interface int-patch-tun type=internal
ovs-vsctl set interface tun-patch-int type=patch options:peer=int-patch-tun
ovs-vsctl set interface int-patch-tun type=patch options:peer=tun-patch-int


ovs-vsctl add-port br-tun vxlan0 -- set interface vxlan0 type=vxlan options:remote_ip=192.168.198.10
ovs-vsctl show
