## Keyword
1. brick
2. volume
3. node
4. cluster
5. replica
6. strip
7. disperse

## Topic
1. volume sharing 
> gls_client, nfs, iscsi, samba
  
## Quickstart
### preparation
```
two nodes,network connection,two disk for OS and glusterfs  
ensure /var/lib and /var/log will not exceed  
setenforce 0 && iptables -F
```
### create partition table for bricks
```
mkfs.xfs -i size=512 /dev/sdb1
mkdir -p /data/brick
echo '/dev/sdb1 /data/brick1 xfs defaults 1 2' >> /etc/fstab
mount -a 
```
### install glusterfs
[repo_address](http://download.gluster.org/pub/gluster/glusterfs/LATEST/CentOS/epel-6/x86_64/)
```bash
yum install glusterfs-server
service glusterd start
```
### configure the trusted pool
```bash
<server1> gluster peer probe server2
<server2> gluster peer probe server1
```
once this pool is created,only pool can probe new server
  
### start a volume
```bash
<server1,server2> mkdir /data/brick1/gv0
<server1> gluster volume create gv0 replica 2 server1:/data/brick1/gv0 server2:/data/brick1/gv0
<server1> gluster volume start gv0
<server1> gluster (interactive shell)
```
### using a volume  
```bash
mount -t glusterfs server1:/gv0 /mnt
```
