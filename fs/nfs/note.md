## Installation
```
yum -y install nfs-utils
```
## Usage
servce rpcbind start
service nfs start


## Configure
```
/path/to/nfs/share <host>(no_root_squash,rw)
```
