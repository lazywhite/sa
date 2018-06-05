## Concept
HDFS is the primary distributed storage used by Hadoop applications  A HDFS   
cluster promarily consists of a NameNode that manages the filesystem metadata  
 and DataNodes that store the data

### NameNode
1. manage the filesystem namespace
2. regulate client access to files
3. execute filesystem operations like "renaming, closing, opening"  
4. 可以启动多个nameNode, 另一个处于standby状态，zookeeper进行master选举
Quorum Journal Manager用来在namenode间共享edits 

### Secondary NameNode
定期合并fsimage 和 edits log， 确保edits log不会太大, 否则一旦namenode重启
会花费大量时间进行启动
   
### DataNode
1. perform read-write operations
2. perfom operation like "block creation, deletion, replication according the  
    instructions of the namenode"

### Block
file in the filesystem will be devided into one or more segments  called blocks  
default block size is 64MB

## Disks
1. no raid controller
2. mounte disk with -noatime
3. set datadir with comma seperated path

### Volume

## Feature
```
Shell like commands to interact with HDFS directly
NameNode and DataNode have built in web servers to show the status 
File permissions and authentications
Safemode for administrative task
fsck: to diagnose health of the filesystem, find missing files or blocks
fetchdt: fetch delegationtoken and store it in a file on the local system
balancer: tool to balance the cluster when data is unevenly distributed
upgrade and rollback: after software upgrade, you can rollback 
secondary namenode: merge "fsimage" and "edits" log periodly
Checkpoint node: 
backup node: an extension to checkpoint node 
```

## Usage
```
prefix: hdfs dfs  or hadoop dfs (deprecated)
cat
chgrp
chmod
chown
copyFromLocal
copyToLocal
cp 
du
distcp: copy files or directories recursively
dus
expunge: cleanup trash
get: 复制文件到本地文件系统 
getmerge: 将HDFS中一个目录的文件连接成一个文件并存放至本地
ls
lsr: ls -R
mkdir
mv
put: 从本地文件系统复制到目标文件系统 
rm: 
rmr: 递归删除
setrep: 改变一个文件的副本数
stat: 指定路径的统计信息
tail: 打印文件尾部1KB数据
test: 检查文件是否存在
text: 将源文件输出为文本格式
touchz: 创建一个0字节的空文件
```

## Safe Mode
```
文件只读
hadoop dfsadmin -safemode [enter, leave, get, wait]
```
