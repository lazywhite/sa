## Keyword
```
HMaster (active, standby)
Region Server
Stores
    Memstore
    HFile
Regions
Table:  a collection of rows
row: a collection of column families
column family: a collection of column
column: a collection of key/value pair

```

## 特点
1. Hbase建立在HDFS之上, 依靠HDFS来获得水平扩展和错误容忍能力
2. HDFS只能顺序处理数据, Hbase是为了解决数据的Random Access问题
3. 不支持事务
4. schema-less
5. 面向列, 便于水平扩容


## HMaster的职责
1. 借助zookeeper, 为RegionServer分配Region
2. 为region实现负载均衡, 调度过度繁忙的region到其他的RegionServer
3. 管理database metadata, 如表和column family的创建  
4. hbase会为数据做哈希索引, 以加快检索速度

  
## RegionServer的职责
1. 接受client请求处理数据
2. client通过zookeeper找到与region对应的regionServer

## HMaster高可用
同时启动多个hmaster, 依靠zookeeper做选举和failover
