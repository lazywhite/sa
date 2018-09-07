## Installation
```
yum -y install nfs-utils
```
## Usage
```
for cent6
    servce rpcbind start
    service nfs start

for cent7
    systemctl start rpcbind nfs-server
    systemctl enable rpcbind nfs-server
```

## Configure
```
server
    /etc/exports
        # /path/to/nfs/share <host>(no_root_squash,rw)
        /share 192.168.0.*(rw,sync)

    exportfs -avr 


client
    showmount -e 192.168.56.70

    mount -t nfs 192.168.0.70:/share /mnt
```

## Sync
```
mount -o sync
```
