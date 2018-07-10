## using dnsmasq as dns server
```
yum -y install dnsmasq

/etc/hosts
    127.0.0.1 localhost 
    192.168.33.125 master1 master1.local.com

/etc/dnsmasq.conf
    listen-address=127.0.0.1,192.168.33.125
    resolv-file=/etc/resolv.dnsmasq
    no-poll

/etc/resolv.dnsmasq
    nameserver 192.168.33.125 # upstream server


/etc/resolv.conf
    search local.com
    namserver 192.168.33.125


# nslookup master1

systemctl start dnsmasq
systemctl enable dnsmasq

# everytime you changed /etc/hosts, you have to restart dnsmasq service
```
