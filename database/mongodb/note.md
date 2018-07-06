## 数据类型
```
String
Integer
Boolean
Double
Min/Max keys
Arrays
Timestamp
Object
Null
Symbol(reserved keyword)
Date
ObjectId
Binary data
Code: javascript code
Regular Expression
```

## 索引
```
1. 没有索引, mongodb会进行全collection扫描
2. 默认创建 unique "_id"索引, 并且无法删除
3. mongodb索引数据结构默认是B-Tree
4. Hash索引, range-base查询无效, 相等查询才有效
5. 不能在已经有重复值的field创建unique index
6. hash索引不能是unique的
7. partial index 只对符合条件的一部分document的相关field做索引
8. sparse index 只对包含index field的document做索引, 因为不包含全部, 所以是稀疏的
9. ensureIndex 在3.0后已被废弃, 使用createIndex
10. 禁止在field value 是float point number的列上创建哈希索引
11. db.users.stats() 查看索引状态

索引类型
    single field 单字段索引
    compound field 联合索引
    multikey  针对field value是数组的索引
    geospatial 针对geospatial coordinate data的索引
    text  全文
    hashed  哈希
索引属性
    unique 唯一的
    partial 部分的
    sparse 稀疏的
    ttl 用在会被mongodb按使用时间自动删除的集合中


后台建立索引
    1. 耗时较长
    2. 索引结构不是很紧凑
    3. 影响到primary节点的写入性能 

前台建立索引的流程
    复制集
        Secondary
            1. 停止一个secondary, 然后以不同端口, 不加入replset的方式启动
                mongod --port 47017
            2. 建立索引
                db.col.createIndex({username: 1})
            3. 重启mongod,设置端口,  加入原先的replset
                mongod --replset rs0 --port 27017
            重复以上流程, 在所有secondary节点建立索引
        Primary
            1. 降为secondary
                rs.stepDown()
            2. 按secondary建立索引的流程进行操作
            

创建索引
    db.col.createIndex(keys, options)
        key
            {field: type}
        options
            background //后台建立索引
            name //索引名称
            unique = <boolean>
            expireAfterSeconds
            partialFilterExpression
            storageEngine
            min
            max

    db.col.createIndex({field1: 1})
    db.col.createIndex({field1: 1, field2: 1}) //联合索引
    db.col.createIndex({"add.zip" : 1}) // multikey index
    db.col.createIndex({field1: 1}, {unique: true}) //唯一索引
    db.restaurants.createIndex( //partial index
       { cuisine: 1 },
       { partialFilterExpression: { rating: { $gt: 5 } } })
    db.eventlog.createIndex(  // ttl index
        { "lastModifiedDate": 1 }, 
        { expireAfterSeconds: 3600 } )
    db.collection.createIndex( { _id: "hashed" } ) //哈希索引, 不使用b-tree

    db.col.createIndex({field1: "text"}) //全文索引
        db.posts.find({$text:{$search:"runoob"}})//使用全文索引

列出索引
    db.col.getIndexes() --> {"name":"_id_"}

删除索引
    db.collection.dropIndex("_id_");
    
```

## Mongodb 日志
### 1. Oplog
```
operation log, 只会在复制集中才会产生
复制集中primary节点会产生oplog, 所有从节点会异步执行此oplog
并且自身会保留一份copy(local.oplog.rs collection), 也可以从其他节点获取oplog entry

oplog本身是一种capped collection, 会按照顺序记录所有对数据库的写入操作
oplog中所有的操作都是幂等的, 不管执行多少次, 总是产生同样的结果
```

### 2. Journal
```
相当于mysql redo log, 写操作之前先写入journal, 保证写的持久化和灾难恢复

开启方法
    mongod --journal | --nojournal 
存放位置
    /data/journal/
        j._32
        j._33
        lsn: last sequence number
db.shutdownServer() 会删除journal目录下除了preallo的其他文件, 表明是正常关闭
如果一个journal文件满1G, 会再创建一个journal文件来使用, 如果某个journal文件上
记录的写操作都被执行过了, 就会把这个journal文件删除
```


### 3. server log
```
记录与mongod运行有关的信息
开启方法
    mongod --logpath=/data/db/logs/server.log -logappend
```
### 4. slow query log
```
mongod --profile=1 --slowms=5(ms) 
    profile level
        0: 不开启
        1: 记录慢日志, 默认为>100ms
        2: 记录所有日志
    profile级别操作
        db.getProfilingLevel()
        db.setProfilingLevel(level, duration(单位毫秒))

慢查询日志是针对单个数据库的, 开启后默认存放在system.profile 这个collection
```
## ObjectId
```
如果新增document的时候, 不指定_id, 或者允许生成_id列, 则会自动生成一个ObjectId()
    > var objid = new ObjectId();
    > objid.getTimestamp() --> ISODate("2017-07-06T13:39:58Z")//获取生成时间
    > objid.str  转化为字符串
```

## Caped collections
大小固定的集合, create, read, delete性能比较高, 类似于RRD

```
>db.createCollection("cappedLogCollection",{capped:true,size:10000})
    size: 单位字节
    max: 最大记录数

>db.cappedLogCollection.isCapped()
    判断集合是否为固定集合:
 
>db.runCommand({"convertToCapped":"posts",size:10000})
    将已存在的集合转换为固定集合

>db.cappedLogCollection.find().sort({$natural: -1})
    按照插入顺序查询

无法从capped collection中删除单条记录, 只能全部删除
没有默认索引, 即使是_id列
32位系统一个capped collection有最大大小限制, 64位则无, 需要人工指定
```

## GridFS 
```
mongodb bson格式的collection默认最大16MB
上传的文件会被分为chunk, 每个chunk会被存储到一个document(最大为255k)里面 

会在文件制定上传的数据库创两个连个collection <prefix>.files来存储元数据,  <prefix>.chunks来存储文件的chunk, 默认前缀为fs

mongofiles <options> <command> <filename or _id>
    command:
        list  列出所有文件, 后面跟filename可只列出以filename开头的文件
        search 搜索文件名包含filename的files
        put   添加一个filename的文件
        get   获取一个filename的文件
        get_id  用_id 获得一个文件
        delete   删除所有filename的文件
        delete_id 删除一个_id的文件

存储文件
    mongofiles -d gridfs put song.mp3
        -d, --db=<database-name> 指定上传到的数据库
        -t, --type=  content/MIME type for put
        -r, --replace  删除其他同名的文件
        --prefix=<prefix> GridFS前缀

查询文件元数据
    >db.fs.files.find()
    {
       _id: ObjectId('534a811bf8b4aa4d33fdf94d'),
       filename: "song.mp3",
       chunkSize: 261120,
       uploadDate: new Date(1397391643474), 
       md5: "e4f53379c909f7bed2e9d631e15c1c41",
       length: 10401959
    }

    >db.fs.chunks.find({files_id: ObjectId('534a811bf8b4aa4d33fdf94d')})

```
## 特殊的数据库

### 1. "config" database

1. 分片集群的配置信息存放在config数据库
2. 连接mongos实例来使用config数据库
3. 相关集合
```
config.change_log
    每个document存储对一个分片集合元数据所做的修改, 包括时间戳, 详细信息等
config.chunks
    每个document对应集群中一个chunk的信息
config.collections
    每个document对应集群中一个分片集合
config.databases
    每个document对应集群中一个数据库, 记录其是否包含分片集合
config.lockpings
    每个document对应分片集群中一个活动的组件
config.locks
    存储分布式锁, config复制集的master节点会写入记录标明自己是主 
config.mongos
    每个document对应分片集群中一个mongos, 健康监测会更新uptime
config.settings
    记录分片配置
        chunksize
        balancer status
        auto split
config.shards
    每个document对应分片集群中一个shard
config.tags
config.version
```


### 2. "local" database
```
local库可以用来存储自身特有的数据
复制集有关的数据存储在local数据库里面
local数据库不参与复制

local.startup_log
local.system.replset
local.oplog.rs
local.replset.minvalid
local.slaves
```

### 3. "admin" database

```
进行系统维护的数据库
    use admin; db.shutdownServer()
```


## 多collection关联
```
mongodb不支持多collection join操作, collection关联使用DBRef

localhost(mongod-3.2.3) new> var user = {
... "_id": 1,
... "name": "bob"
... }
localhost(mongod-3.2.3) new> db.user.insert(user)

localhost(mongod-3.2.3) new> var p = {
... _id: 1,
... content: "haaldkfj",
... author: {
... $ref: "user",
... $id: 1, 
... $db: "new"  //可选参数
... }}
localhost(mongod-3.2.3) new> db.post.insert(p)

db.post.findOne().author.fetch()

```

## 修改replset优先级
```
cfg = rs.conf()
cfg.members[0].priority = 0.5
cfg.members[1].priority = 2
cfg.members[2].priority = 2
rs.reconfig(cfg)
```

## 聚合操作
```
aggregate()
    $sum
    $max
    $min
    $avg
    $push
    $addToSet
    $first
    $last
    $group

count()
distinct()
group() @deprecated
mapreduce()
```
## 经验
```
mongodb没有类似于mysql binlog的日志

设置mongodb最大可用内存, 新版默认为系统内存的一半
    mongod.conf
        wiredTigerCacheSizeGB = 1
    
mongodb每个document最大为16MB, 所以使用embbed document要小心, 最好使用seperated document

查看连接的是否是mongos实例
    use admin
    db.isMaster() --> "msg": "isdbgrid" ## show it is mongos otherwise not

查看分片分布信息
    db.col.getShardDistribution()

查看集合大小
    db.col.stats() #  内存大小
    db.col.storageSize() # 物理大小, 可能被压缩过

分片集群中一个chunk默认最大为64MB
use <dbname> # 在内存中创建数据库, 没有写入数据就离开, 会被销毁

mongodb为单个文档提供原子操作
    db.col.findAndModify() 

mongod进程cpu占用率较高, 可能是缺少索引

bson and Mongodb
    BSON is a binary-encoded serialization of JSON-like documents. BSON is designed to be lightweight, traversable, and efficient.

命令行增强
    npm install -g mongo-hacker
```


## 实现自增_id
```
//创建产生自增编号的sequence
db.counters.insert({
    _id: "productid",
    "sequence_value": 0
})

//定义获得自增编号的函数
>function getNextSequenceValue(sequenceName){
   var sequenceDocument = db.counters.findAndModify(
      {
         query:{_id: sequenceName },
         update: {$inc:{sequence_value:1}},
         new:true
      });
   return sequenceDocument.sequence_value;
}

//实现自增
db.products.insert({
   "_id":getNextSequenceValue("productid"),
   "product_name":"Apple iPhone",
   "category":"mobiles"})
```


## mongod系统参数优化 

```
numactl --interleave=all mongod --config /data/mongodb/mongodb.conf

sysctl -w vm.overcommit_memory=1
//or 
$pid=`pidof mongod` echo -17 >  /proc/$pid/oom_adj


//disable swappiness
sysctl -w vm.swappiness=0

//change ssd io scheduler
echo noop > /sys/block/sda/queue/scheduler
```
