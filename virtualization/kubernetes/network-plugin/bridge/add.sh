#!/bin/bash
set -ex

CID=$(docker run --rm -d --network=none alpine sh -c "sleep infinity")
PID=$(docker inspect ${CID}|jq -r ".[0].State.Pid")


if [ ! -d /var/run/netns ];then
    mkdir -p /var/run/netns
    chmod 755 /var/run/netns
    chown root.root /var/run/netns
fi


export CNI_COMMAND=ADD
export CNI_PATH=/opt/cni/bin
export CNI_CONTAINERID=demo-$PID
export CNI_NETNS=/proc/$PID/ns/net
export CNI_IFNAME=eth0

ln -sfT /proc/$PID/ns/net /var/run/netns/$CNI_CONTAINERID

/opt/cni/bin/bridge < bridge.conf
