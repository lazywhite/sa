iptables -t nat -F
iptables -t filter -F
iptables -t mangle -F
iptables -t raw -F

ip6tables -t nat -F
ip6tables -t filter -F
ip6tables -t mangle -F
ip6tables -t raw -F

#iptables -L -n|grep -i "chain cali-"|awk '{print $2}'|while read line;do iptables -X $line;done
#iptables  -t nat -L -n|grep -i "chain cali-"|awk '{print $2}'|while read line;do iptables -t nat -X $line;done
 
iptables -L -n|grep "0 references"|awk '{print $2}'|while read line;do iptables -X $line;done
iptables -t nat -L -n|grep "0 references"|awk '{print $2}'|while read line;do iptables -t nat -X $line;done
iptables -t raw -L -n|grep "0 references"|awk '{print $2}'|while read line;do iptables -t raw -X $line;done
iptables -t mangle -L -n|grep "0 references"|awk '{print $2}'|while read line;do iptables -t mangle -X $line;done


service iptables save
