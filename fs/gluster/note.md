## volume create prompt already created
1. 在/test/data1和/test/data2目录中删除".glusterfs"的目录
2. setfattr -x trusted.glusterfs.volume-id /test/data1
3. setfattr -x trusted.gfid /test/data1
4. setfattr -x trusted.glusterfs.volume-id /test/data2
5. setfattr -x trusted.gfid /test/data2


## Topic
### Volume access protocol
1. NFS (builtin support)
2. Glusterfs(builtin support)
3. ISCSI(plugin required)
4. Samba(plugin required)
