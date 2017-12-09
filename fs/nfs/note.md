## Installation
```
yum -y install nfs-utils
```
## Usage
```
servce rpcbind start
service nfs start
```

## Configure
```
/etc/exports
    # /path/to/nfs/share <host>(no_root_squash,rw)
    /share 192.168.0.*(rw,sync)


exportfs -avr 
```
