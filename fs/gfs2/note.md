## Concept
DLM: distribute lock manager
## Install
创建一个GFS文件系统：
需要提供的信息：
1、锁类型：
	lock_nolock
	lock_dlm
2、锁文件的名字，通常即文件系统名
	cluster_name:fs_name
3、日志的个数，通常一个节点对应一个日志文件，但建议提供比节点数更多的日志数目，以提供冗余；
4、日志文件大小
5、文件系统大小

Syntax: gfs_mkfs -p lock_dlm -t ClusterName:FSName -j Number -b block_size -J journal_size BlockDevice

如：
# gfs_mkfs -p lock_dlm -t gfscluster:gfslv -j 5 /dev/vg0/gfslv
	
可以通过其对应挂载点查看gfs文件系统属性信息；
# gfs_tool df /mount_point


挂载GFS文件系统：
mount -o StdMountOpts,GFSOptions -t gfs DEVICE MOUNTPOINT

前提：挂载GFS文件的主机必须是对应集群中的节点；

挂载GFS文件时有如下常用选项可用：
lockproto=[locl_dlm,lock_nolock]
locktable=clustername:fsname
upgrade # GFS版本升级时有用
acl

如果不想每一次启用GFS时都得指定某选项，也可以通过类似如下命令为其一次性指定:
# gfs_tool margs "lockproto=lock_dlm,acl"



载入相应的gfs模块，并查看lv是否成功

# modprobe gfs
# modprobe gfs2
# chkconfig gfs on
# chkconfig gfs2 on

# chkconfig clvmd on

# /etc/init.d/gfs restart
# /etc/init.d/gfs2 restart
# /etc/init.d/clvmd restart

# lvscan
lvmconf --enale-cluster

