firewall-cmd --status
firewall-cmd --state
firewall-cmd --get-default-zone
firewall-cmd --get-active-zones
firewall-cmd --get-zones
firewall-cmd --zone=public --list-all
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --permanent --zone=public --list-ports
firewall-cmd --zone=public --list-rich-rule
firewall-cmd --reload
firewall-cmd --permanent --zone=trusted --add-source=192.168.2.0/24
firewall-cmd --zone=trusted --list-sources



As an exemple of source management, let’s assume you want to only 
allow connections to your server from a specific IP address (here 1.2.3.4/32).

# firewall-cmd --zone=internal --add-service=ssh --permanent
success
# firewall-cmd --zone=internal --add-source=1.2.3.4/32 --permanent
success
# firewall-cmd --zone=public --remove-service=ssh --permanent
success
# firewall-cmd --reload
success


# firewall-cmd --zone=internal --add-port=443/tcp
