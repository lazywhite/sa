## Keyword
```
HMaster (active, standby)
Region Server
Stores
    Memstore
    HFile(store file)
Region
    state存储在hbase:meta中
Table:  a collection of rows
row: row_key, column name, value, timestamp
column family: a collection of column
column: 
cell: 存储的value没有类型, 统一为byte[]
timestamp: 作为version标识符, 每个cf独立设置, 默认为3(<=0.96), 1(>0.96)
row key: 数字或字符串(按字母顺序存储)

namespace: 默认有hbase, default
Hlog: write-ahead log 灾难恢复使用
```
## Object hierarchy
```
table
    region (横向切分)
        store (每个CF一个store)
            memstore (内存中)
            storefile (HDFS中)
                block
```

## Cluster
```
HMaster
HRegionServer
zookeeper
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

## column family
每个table的cf最好只有一个, 2个以上的cf会带来性能问题
每个CF可设置TTL, 过期的row会被自动删除, 仅包含过期row的store file会被删除(可全局禁用这个特性)

保存被删除的cell
    alter ‘t1′, NAME => ‘f1′, KEEP_DELETED_CELLS => true
    scan 'test', {RAW=>true, VERSIONS=>1000} # 显示被删除cell
    flush 't1' # 仍不会删除
    major_compact 't1' # 会被删除

## Row key
Rows in HBase are sorted lexicographically by row key
为了防止读写集中在某个regionServer, row key设计可参考以下方法
    salting: 加random前缀, 减轻写压力, 增加读延迟
    hashing: one-way hash
    reversing: 将key倒序,把经常变化的部分放在前面

同一个table的不同cf, 可以包含相同的row key
row key一旦写入无法更改
同一个CF的不同column, 可以有相同的row key

## catalog tables
hbase:meta 保存了所有region的列表, location存储在zookeeper
