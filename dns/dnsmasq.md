## using dnsmasq as dns server
```
# /etc/dnsmasq.conf
listen-address=IP

# /etc/resolve.conf
nameserver 127.0.0.1 

# restart network and dnsmasq service
# everytime you changed /etc/hosts, you have to restart dnsmasq service
```
