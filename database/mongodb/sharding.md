## 结论
1. 给collection创建分片, 需要collection已经存在索引, sharding的类别就是索引的类别
1. 一旦开始shard一个集合, shard key 和 valued就不可变了, 不能挑选另外的shard key 或者更新document "shard key fields"对应的value
1. 最好在shard集群中开启auto split
1. Balancer进程默认是开启的, 备份时需要关闭
1. chunk size默认64MB, 范围在1-1024MB, 如果chunk size较小, 则会触发频发的chunk migration
    调整chunk大小: use config; db.settings.save({_id:"chunksize", value: <size in MB> })
1. mongos路由时, 会根据shard key value来决定属于哪个zone, 然后路由给zone中的shard
1. 分片集群中第一个shard往往是primary shard
1. database中没有开启shard的collection, 全部存放在primary shard
1. 如果采用hash sharding, 可考虑采用预分片技术, 指定numInitialChunks, 均匀分布到各个shard, 如果采用range sharding, 预分片效果不大, 可能会产生空chunk


## Zone (new in 3.4, successor of "tag aware shard")
```
一个shard上所有的sharding key value可以分为多个range或单个range
一个range只能分配给一个zone
由于一个shard上可以有多个range, 因此shard跟zone是多对多关系
每个zone覆盖一个或多个shard key value range, 每个range都是包含下限, 不包含上限
zone管理的range不能与其他zone不能有任何交叉
```

## 如何搭建一个shard cluster
```
1. 创建shard1 replset, shard2 replset ...
2. 创建config replset
3. 启动mongos 并指定config server   mongos --configdb=<host1>:<port1>,<host2>:<port2>...
4. 连接mongos, 添加shard   use admin; sh.addShard()
```
## 如何shard一个集合
```
1. 连接mongos节点进行操作
2. 在库级别开启sharding功能
    sh.enableSharding("<database>")'
3. 确保shard key field已经存在索引, shard的类型由index的类型决定
    "db.collection.createIndex()" 
4. 开启shard
    "sh.shardCollection()"
```

### Balancer
```
mongos节点可以发起一个balancing round, 需要预先在config.lock 里面写入信息以获取lock
为了将对集群性能的影响降到最低
    1. balancer一次只移动一个chunk
    2. 只会在一个collection拥有最多chunk数量的shard与最少chunk数量的shard之间chunk number的差值大于规定值(默认为8)时才会开始一个balancing round
一旦一个balancing round开启, 在差值小于2或者失败的时候才会停止
根据差值的多少, 有可能开启多个线程进行migration
```

### Chunk转移流程
1. balancer进程发送moveChunk()命令到原始chunk
2. 在转移没结束前, 原始chunk负责所有的读写
3. 首先在目标位置建立索引
4. 目标开始从原始chunk同步数据
5. 获取完毕后, 开启一个同步进程来同步, 
6. 同步完毕后, 目标shard联系config, 更新chunk元数据, 标明其新位置
7. 如果chunk元数据已更新, 并且原始chunk没有打开的cursor, 原始chunk将被删除


## Chunk分裂与聚合
1. mergeChunks() 可以将一个空chunk与其在同一个shard的chunk聚合成一个
2. 如果没有document匹配到这个chunk的shard key range, 这个chunk就会是空chunk
3. mongodb只会把处于某个zone的chunk移动到同属于这个zone的其他shard
4. 最开始只有primary shard有chunk, range是[minKey, maxKey], 随着写入数据量的增加, 不断触发chunk分裂, 每个chunk负责的range也会改变, 最终导致各个shard上的chunk分布不均, 触发chunk migration, 新的shard负责的range就包含迁移过来的chunk的range

