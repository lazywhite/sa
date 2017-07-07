## 结论
1. 需要一个sharding key才能创建分片集群
2. sharding key 可以是single field 或compound field类型的
3. sharding 的类型分为两种B-Tree(ranged), Hashed
4. 一旦开始shard一个集合, shard key 和 valued就不可变了, 不能挑选另外的shard key 或者更新document "shard key fields"对应的value
5. 禁止在field value 是float point number的列上创建哈希索引
6. 如果在一个空集合上创建哈希分片, 则mongodb自动为每个shard创建两个空chunk, 可以通过"numInitialChunks" 来指定
7. 最好在shard集群中开启auto split
8. 采用预分裂技术, 有助于提高分片集群性能
9. 只有开启了shard的collection才会被分片(废话), 不开启则不会
10. Balancer进程默认是开启的, 备份时需要关闭
11. chunk size默认64MB, 范围在1-1024MB, 如果chunk size较小, 则会触发频发的chunk migration
    调整chunk大小: use config; db.settings.save({_id:"chunksize", value: <size in MB> })
12. 可以在添加一个shard的时候规定数据最大值, 默认不限制   


## Zone (new in 3.4, successor of "tag aware shard")
```
基于shard key 可以创建zone, zone跟shard之间是多对多关系
每个zone覆盖一个或多个shard key value range, 每个range都是包含下限, 不包含上限
单个shard可能只有一个range
zone管理的range不能与其他zone不能有任何交叉
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
    2. 只会在一个collection拥有最多chunk数量的shard与最少chunk数量的shard之间chunk number的差值大于规定值时才会开始一个balancing round
一旦一个balancing round开启, 在差值小于2或者失败的时候才会停止
根据差值的多少, 有可能开启多个线程进行migration
```

### Chunk转移流程
1. The balancer process sends the moveChunk command to the source shard.
2. The source starts the move with an internal moveChunk command. During the migration process, operations to the chunk route to the source shard. The source shard is responsible for incoming write operations for the chunk.
3. The destination shard builds any indexes required by the source that do not exist on the destination.
4. The destination shard begins requesting documents in the chunk and starts receiving copies of the data.
5. After receiving the final document in the chunk, the destination shard starts a synchronization process to ensure that it has the changes to the migrated documents that occurred during the migration.
6. When fully synchronized, the destination shard connects to the config database and updates the cluster metadata with the new location for the chunk.
7. After the destination shard completes the update of the metadata, and once there are no open cursors on the chunk, the source shard deletes its copy of the documents.

