#!/bin/bash
IPTABLES_BIN="/sbin/iptables"

# cat /etc/resolv.conf
DNS_SERVER="8.8.4.4 8.8.8.8"

# /etc/hosts
ALLOWED_HOST="13.229.188.59"

echo "flush iptable rules"
$IPTABLES_BIN -F
$IPTABLES_BIN -X
$IPTABLES_BIN -t nat -F
$IPTABLES_BIN -t nat -X
$IPTABLES_BIN -t mangle -F
$IPTABLES_BIN -t mangle -X


for ip in $DNS_SERVER
do
	echo "Allowing DNS lookups (tcp, udp port 53) to server '$ip'"
	$IPTABLES_BIN -A OUTPUT -p udp -d $ip --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
	$IPTABLES_BIN -A INPUT  -p udp -s $ip --sport 53 -m state --state ESTABLISHED     -j ACCEPT
	$IPTABLES_BIN -A OUTPUT -p tcp -d $ip --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
	$IPTABLES_BIN -A INPUT  -p tcp -s $ip --sport 53 -m state --state ESTABLISHED     -j ACCEPT
done

echo "allow all on localhost"
$IPTABLES_BIN -A INPUT -i lo -j ACCEPT
$IPTABLES_BIN -A OUTPUT -o lo -j ACCEPT

for ip in $ALLOWED_HOST
do
	echo "Allow connection to '$ip' on port 22"
	$IPTABLES_BIN -A OUTPUT -p tcp -d "$ip" --dport 22  -m state --state NEW,ESTABLISHED -j ACCEPT
	$IPTABLES_BIN -A INPUT  -p tcp -s "$ip" --sport 22  -m state --state ESTABLISHED     -j ACCEPT

	echo "Allow connection to '$ip' on port 80"
	$IPTABLES_BIN -A OUTPUT -p tcp -d "$ip" --dport 80  -m state --state NEW,ESTABLISHED -j ACCEPT
	$IPTABLES_BIN -A INPUT  -p tcp -s "$ip" --sport 80  -m state --state ESTABLISHED     -j ACCEPT

	echo "Allow connection to '$ip' on port 443"
	$IPTABLES_BIN -A OUTPUT -p tcp -d "$ip" --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
	$IPTABLES_BIN -A INPUT  -p tcp -s "$ip" --sport 443 -m state --state ESTABLISHED     -j ACCEPT
done


echo "Allowing new and established incoming connections to port 21, 22, 80, 443"
$IPTABLES_BIN -A INPUT  -p tcp -m multiport --dports 21,22,80,443 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPTABLES_BIN -A OUTPUT -p tcp -m multiport --sports 21,22,80,443 -m state --state ESTABLISHED     -j ACCEPT

echo "Allow all outgoing connections to port 22"
$IPTABLES_BIN -A OUTPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPTABLES_BIN -A INPUT  -p tcp --sport 22 -m state --state ESTABLISHED     -j ACCEPT

echo "Allow outgoing icmp connections (pings,...)"
$IPTABLES_BIN -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
$IPTABLES_BIN -A INPUT  -p icmp -m state --state ESTABLISHED,RELATED     -j ACCEPT

echo "Allow outgoing connections to port 123 (ntp syncs)"
$IPTABLES_BIN -A OUTPUT -p udp --dport 123 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPTABLES_BIN -A INPUT  -p udp --sport 123 -m state --state ESTABLISHED     -j ACCEPT

# Log before dropping
$IPTABLES_BIN -A INPUT  -j LOG  -m limit --limit 12/min --log-level 4 --log-prefix 'IP INPUT drop: '
$IPTABLES_BIN -A INPUT  -j DROP

$IPTABLES_BIN -A OUTPUT -j LOG  -m limit --limit 12/min --log-level 4 --log-prefix 'IP OUTPUT drop: '
$IPTABLES_BIN -A OUTPUT -j DROP


echo "Set default policy to 'DROP'"
$IPTABLES_BIN -P INPUT   DROP
$IPTABLES_BIN -P FORWARD DROP
$IPTABLES_BIN -P OUTPUT  DROP
