#!/bin/bash
# docker container赋固定IP脚本
# 需要开启ssh服务， 分配固定IP, 初始密码为root
uuid=`docker create -t -i -v /etc/localtime:/etc/localtime:ro --name=$1 --memory=$2 --net="none" cppking/hrcf:latest`
docker start $uuid
pid=`docker inspect -f "{{.State.Pid}}" $1`
ln -s /proc/$pid/ns/net /var/run/netns/$pid
eid=`echo $uuid|cut -c -6`
vname=veth_$eid

ip link add $vname type veth peer name X
brctl addif br0 $vname
ip link set $vname up
ip link set X netns $pid


ip netns exec $pid ip link set dev X name eth0
ip netns exec $pid ip link set eth0 up
ip netns exec $pid ip addr add $3/24 dev eth0
ip netns exec $pid ip route add default  via 192.168.1.1
# /etc/pam.d/sshd
#session    optional     pam_loginuid.so
#session    optional     pam_keyinit.so force revoke
