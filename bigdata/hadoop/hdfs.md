## Concept
HDFS is the primary distributed storage used by Hadoop applications  
A HDFS cluster promarily consists of a NameNode that manages the filesystem  
metadata and DataNodes that store the data
## Install

ssh must enabled
## Feature
Shell like commands to interact with HDFS directly
NameNode and DataNode have built in web servers to show the status 
File permissions and authentications
Safemode for administrative task
fsck: to diagnose health of the filesystem, find missing files or blocks
fetchdt: fetch delegationtoken and store it in a file on the local system
balancer: tool to balance the cluster when data is unevenly distributed
upgrade and rollback: after software upgrade, you can rollback 
secondary namenode
Checkpoint node: 
backup node: an extension to checkpoint node 
## Usage
hdfs-site.xml
hdfs fs -help
## Document
NameNode persists its namespace using two files: fsimage, which is the latest checkpoint of the namespace and edits, a journal (log) of changes to the namespace since the checkpoint.

The secondary NameNode merges the fsimage and the edits log files periodically and keeps edits log size within a limit. It is usually run on a different machine than the primary NameNode since its memory requirements are on the same order as the primary NameNode.




## Usage
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



hdfs dfs -rm -r hdfs://path/to/file
## Question
how hdfs-cli or other Client communitate with HDFS
hdfs:// protocol    
## HDFS port
9000    fs.defaultFS，如：hdfs://172.25.40.171:9000
9001    dfs.namenode.rpc-address，DataNode会连接这个端口
50070   dfs.namenode.http-address
50470   dfs.namenode.https-address
50100   dfs.namenode.backup.address
50105   dfs.namenode.backup.http-address
50090   dfs.namenode.secondary.http-address，如：172.25.39.166:50090
50091   dfs.namenode.secondary.https-address，如：172.25.39.166:50091
50020   dfs.datanode.ipc.address
50075   dfs.datanode.http.address
50475   dfs.datanode.https.address
50010   dfs.datanode.address，DataNode的数据传输端口
8480    dfs.journalnode.rpc-address
8481    dfs.journalnode.https-address
8032    yarn.resourcemanager.address
8088    yarn.resourcemanager.webapp.address，YARN的http端口
8090    yarn.resourcemanager.webapp.https.address
8030    yarn.resourcemanager.scheduler.address
8031    yarn.resourcemanager.resource-tracker.address
8033    yarn.resourcemanager.admin.address
8042    yarn.nodemanager.webapp.address
8040    yarn.nodemanager.localizer.address
8188    yarn.timeline-service.webapp.address
10020   mapreduce.jobhistory.address
19888   mapreduce.jobhistory.webapp.address
2888    ZooKeeper，如果是Leader，用来监听Follower的连接
3888    ZooKeeper，用于Leader选举
2181    ZooKeeper，用来监听客户端的连接
60010   hbase.master.info.port，HMaster的http端口
60000   hbase.master.port，HMaster的RPC端口
60030   hbase.regionserver.info.port，HRegionServer的http端口
60020   hbase.regionserver.port，HRegionServer的RPC端口
8080    hbase.rest.port，HBase REST server的端口
10000   hive.server2.thrift.port
9083    hive.metastore.uris
