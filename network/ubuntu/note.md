/etc/network/interfaces.d/ifcfg-eno2

auto eno2
iface eno2 inet static
address 192.168.33.88
netmask 255.255.255.0
gateway 192.168.33.254

service networking restart
