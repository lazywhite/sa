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

```

## Safe Mode
```
文件只读
hadoop dfsadmin -safemode [enter, leave, get, wait]
```
