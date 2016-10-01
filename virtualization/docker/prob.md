## inside docker 
issue: TERM environment variable not set.
export TERM=xterm


## follow docker log output

docker logs -f <cid>

docker logs --tail=200 <cid>


## DNAT for container
```
root@jst-hangzhou-10-45-50-65:~#  iptables -t nat -L -n
Chain PREROUTING (policy ACCEPT)
target     prot opt source               destination
DOCKER     all  --  0.0.0.0/0            0.0.0.0/0            ADDRTYPE match dst-type LOCAL
DNAT       tcp  --  0.0.0.0/0            10.45.50.65          tcp dpt:27202 to:192.168.0.2:5432

Chain INPUT (policy ACCEPT)
target     prot opt source               destination

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
DOCKER     all  --  0.0.0.0/0           !127.0.0.0/8          ADDRTYPE match dst-type LOCAL

Chain POSTROUTING (policy ACCEPT)
target     prot opt source               destination
MASQUERADE  all  --  192.168.0.0/20       0.0.0.0/0
MASQUERADE  tcp  --  192.168.0.2          192.168.0.2          tcp dpt:5432

Chain DOCKER (2 references)
target     prot opt source               destination
RETURN     all  --  0.0.0.0/0            0.0.0.0/0
DNAT       tcp  --  0.0.0.0/0            10.45.50.65          tcp dpt:27202 to:192.168.0.2:5432
```
