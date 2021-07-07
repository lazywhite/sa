source ./profile

MAC1=$(get_pod_mac pod1)
MAC2=$(get_pod_mac pod2)
VIFMAC=$(get_vif_mac)

:<<xx
xx

ebtables -t nat -F

ebtables -t nat -A PREROUTING -p IPv4 --ip-dst 192.168.1.1  -j dnat --to-dst $MAC1  --dnat-target ACCEPT
ebtables -t nat -A PREROUTING -p IPv4 --ip-dst 192.168.1.2  -j dnat --to-dst  $MAC2 --dnat-target ACCEPT

ebtables -t nat -A POSTROUTING -p IPv4 --ip-src 192.168.1.1  -j snat --to-src  $VIFMAC --snat-target ACCEPT
ebtables -t nat -A POSTROUTING -p IPv4 --ip-dst 192.168.1.2  -j snat --to-src  $VIFMAC --snat-target ACCEPT
ebtables -t nat -A PREROUTING -p arp  -i bond0.11 --arp-op Request --arp-ip-dst  192.168.1.1 -j arpreply --arpreply-mac ${VIFMAC}
ebtables -t nat -A PREROUTING -p arp  -i bond0.11 --arp-op Request --arp-ip-dst  192.168.1.2 -j arpreply --arpreply-mac ${VIFMAC}

ebtables -t nat -A PREROUTING -p arp  -i bond0.11 --arp-op Reply  --arp-ip-dst 192.168.1.1 -j dnat --to-dst ${MAC1} --dnat-target ACCEPT
ebtables -t nat -A PREROUTING -p arp  -i bond0.11 --arp-op Reply  --arp-ip-dst 192.168.1.2 -j dnat --to-dst ${MAC2} --dnat-target ACCEPT

ebtables -t nat -A POSTROUTING -p arp  -o bond0.11 --arp-op Request  --arp-ip-src 192.168.1.1 -j snat --to-src ${VIFMAC} --snat-arp --snat-target ACCEPT 
ebtables -t nat -A POSTROUTING -p arp  -o bond0.11 --arp-op Request  --arp-ip-src 192.168.1.2 -j snat --to-src ${VIFMAC} --snat-arp --snat-target ACCEPT 


:<<xx
ip link add dev svc-pod1 type veth peer name mac-pod1
ip link add dev svc-pod2 type veth peer name mac-pod2

brctl addif rama11 mac-pod1
brctl addif rama11 mac-pod2
xx
