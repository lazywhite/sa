title: ZFS
date: 2014-08-19 13:30:58
tags: zfs
categories: [tech]
---
## Introduction
  
1. zfs use the concept of *storage pool* to manage physical storage. It don't have *volume manager* , filesystem is high-level than physical device.   

2. zfs is a transactional filesystem, which means the filesystem state is always  consistent on disk.  
  
3. snapshot is a read-only copy of a filesystem or volume and consume no additional space within the pool   
  
4. zfs provides a greatly simplified administration model, it has hierachical filesystem layout, automatic management of mount point and NFS share semantic  you can easily set quotas or reservations, turn compression on or off, or  manage mount point for numerous filesystems with a single command, you can send  or receive filesystem snapshot stream.  
<!-- more -->

## Keyword
```
disk  
pool
    property  

raidz  
volume
    property 
    share  
snapshot  
```

## zpool
### Usage
```
# zpool create <pool_name> <type> /path/to/disk ...
zpool create tank mirror c1t0d0 c2t0d0 mirror c3t0d0 c4t0d0
zpool create pool mirror c0d0 c1d0 spare c2d0 c3d0(hot spare)
zpool create pool c0d0 c1d0 log c2d0 (store intend log on specified device)
zpool create pool c0d0 c1d0 cache c2d0 c3d0(for read-heavy workload,cache)
echo | format(list all bricks in /dev/dsk/)
zpool iostat -v tank 2
zpool status -v[l] tank
zpool status -x
zpool add tank raidz3 c2t1d0 c2t2d0 c2t3d0
zpool add tank log mirror c0t0d0 c1t0d0
zpool clean tank [brick] (clean error count of zpool)
zpool replace tank c1t1d0 [c1t2d0](whether disk is in the same location)
zpool attach pool <device> <new device> (mirror)
zpool detach (spare or failed )
zpool export <pool>(pool must command whole disk)
zpool import [-d] (if device is not in default /dev/dsk/)
zpool get all tank
zpool list -H(headless,script mode) -o name,size (properties)
zpool history
zpool upgrade(online upgrade)
zpool set autoexpand=on rpool
```
### zpool property  
```
allocated,capacity,free = 已分配,比率
autoreplace
altroot = alternate root directory
bootfs
cachefile
dedupditto
dedupratio
delegation = 委派，托管
failmode
guid
health
listshares = whether display share information when use *zfs list*
listsnapshots 
readonly
size
version
```
### zpool health status  
```
degraded
online
suspended
unavail

**zpool status** also provides information about scrub or resilver details
```

## volume
```
zfs create  tank/volume
zfs set mountpoint=/export/volume  tank/volume
zfs set share.nfs=on tank/volume
zfs set compression=on tank/volume
zfs set quota=30G　tank/volume
zfs set volsize=10G rpool/dump(resize the space of volume)
zfs get compression tank/volume
zfs get all tank/volume
zfs rename tank/volume tank/volume_old
zfs set copy=<1|2|3> tank/volume(ditto,multiple metadata)
zfs set dedup=on (space saving, although deduplication is set as filesystem property,  
it's scope is pool-wide)
zfs mount |grep tank/volume
zfs get share.nfs.all tank/volume  (/etc/dfs/sharetab)
zfs set share.nfs.<anon|rw|nosuid> tank/volume
zfs list -t <share|snapshot|all>
```

## Topic
### How to replace a disk in a zfs Root Pool
```
zpool offline rpool c1t0d0s0
cfgadm -c unconfigure c1::dsk/c1t0d0
<physical remove failed disk c1t0d0>
<physical insert new disk c1t0d0>
cfgadm -c configure c1::dsk/c1t0d0
zpool replace rpool c1t0d0s0
zpool online rpool c1t0d0s0
zpool status rpool 
<let disk resilver before installing the boot blocks>
bootadm install-bootloader
```
### how to create a BE in another Root Pool
```
zpool create -B rpool2 c2t2d0
beadm create -p rpool2 solaris2
bootadm install-bootloader -P rpool2
zpool set bootfs=rpool2/ROOT/solaris2 rpool2
beadm activate solaris2 (then reboot)
zfs create -V 4g rpool2/swap 
/dev/zvol/dsk/rpool2/swap - - swap - no -(add it to /etc/vfstab)
zfs create -V 4g rpool2/dump
dumpadm -d /dev/zvol/dsk/rpool2/dump(recreate the dump device)
```


### creating a new pool by splitting a **mirrored** zfs storage pool
```
zpool split tank tank2 && zpool import tank2
```
### how to migrate a Filesystem to ZFS
```
pkg install shadow-migration
svcadm enable shadowd
zfs set readonly=on tank/vol (migrate local zfs filesystem)
share -F nfs -o ro /export/home/ufsdata  
share
zfs create -o shadow=file:///rpool/old users/home/shadow
zfs create -o shadow=nfs://neo/export/home/ufsdata users/home/shadow
shadowstat
when the migration is done, zfs get shadow users/home/shadow = none
```

### snapshot and clone
```
recursive snapshots are created quickly as one atomic operation  
snapshot can not access directly, they can be cloned,backed up,rolled back,
snapshot have no modified properties 
a dataset cannot be destroyed if snapshots of dataset exist 
holding a snapshot prevents it from being destroyed 

zfs snapshot -r tank@first
zfs destroy -r tank@first
zfs hold [-r] keep tank/volume@sec  \\ zfs destroy -d tank/volume@sec
zfs holds [-r] tank/volume@sec
zfs release -r keep tank/volume@sec
zfs rename tank/vol@now tommorow ( rename can only used in same pool)
zfs list -o space -r tank
zfs rollback(the filesystem reverts to its state at the time the snapshot  
was taken,by default the most recent snapshot)
zfs rollback [-r|R] (force delete intermediate snapshot) tank/vol
zfs list -t snapshot -o name,creation tank/vol (+ - M R)

#clone is a writable volume or filesystem,whose initial contents are the
same as the dataset from which it was created
clone can only be created from snapshot, the original snapshot cannot be  
destroyed if any clone exists.
clones do not inherit the properties of the dataset from which it was created
clone has modified properties
```

### replace a zfs filesystem with a ZFS clone
```
zfs create tank/test
zfs create tank/test/productA
zfs snapshot tank/test/productA@today
zfs clone tank/test/productA@today tank/test/productAbeta
zfs list -r tank/test
zfs promote tank/test/productAbeta
zfs list -r tank/test
zfs rename tank/test/productA tank/test/productAlegacy
zfs rename tank/test/productAbeta tank/test/productA
zfs destroy tank/test/productAlegacy
```
### sending and receiving zfs data
```
zfs send command creates a stream representation of a snapshot that is written
to standart output. By default, a full stream is generated, you can redirect 
the output to a file or to a different system.
  
zfs receive command creates a snapshot whose content are specified in the stream 
that is provided on standart input , If a full stream is received, a new filesystem  
is created as well.

# snapshot stream type: Full stream, Incremental stream
stream package is a stream type that contains one or more full or incremental 
streams , three types of stream package exist:
	Replication stream package
	Recursive stream package 
	Self-contained recursive stream package 

zfs send -R (all dataset,include hierachy)
zfs send -I (all increment)
```

### using a zfs volume as a solaris ISCSI target
```
zfs create tank/vol
zfs set shareiscsi=on tank/vol
iscsiadm list target
zfs rename tank/vol tank/volume
```

### zfs delegation
```
zfs allow cindy create,destroy,mount,snapshot tank/vol
zfs unallow cindy tank/vol
<cindy> zfs create tank/vol (can't mount, change the owner of /tank/vol)
chmod A+user:cindy:add_subdirectory:fd:allow /tank
# zfs allow staff create,mount tank/home
# zfs allow -c create,destroy tank/home(create time)
zfs allow -s @myset create,destroy,mount,snapshot,promote,clone,readonly tank(permission set)
zfs allow staff @myset,rename tank
chmod A+group:staff:add_subdirectory:fd:allow tank
```
### using zfs as dump or swap device
```
swap -l
dumpadm
zfs create -V 2G rpool/swap2
swap -a /dev/zvol/dsk/rpool/swap2
```


## ZFS backup script

```bash
#!/bin/bash
## you should use "zfs snapshot -r tank@date ; zfs send -R tank@date | ssh xxx zfs recv " for the
## very first time data full backup.
## then this script will send incremental snapshot stream to backup server,  find out new volumes 
## and send full data stream to backup server

## tips: snapshots consume no extra disk space,so there is no need to delete them.

export PATH=/usr/bin:/usr/sbin
. /opt/pre-snap-date
export current_date=`date +%F`
export pre_volume_list=/opt/volume-list-$pre_snap_date
export current_volume_list=/opt/volume-list-$current_date
export backup_server=172.16.16.14

zfs list -o name -H -r tank |grep -v '^tank$' > $current_volume_list
zfs snapshot -r tank@$current_date

echo 'sending snapshot ...'

egrep -f $pre_volume_list  $current_volume_list | while read line;do
        zfs send -i $line@$pre_snap_date $line@$current_date | ssh $backup_server zfs recv -vF -d tank 
done

echo 'sending new volumes ...'

egrep -vf $pre_volume_list  $current_volume_list | while read line;do
        zfs send  $line@current_date | ssh $backup_server zfs recv -vF -d tank 
        sleep 60
done 

cat > /opt/pre-snap-date <<EOF
export pre_snap_date=$current_date
EOF
```
