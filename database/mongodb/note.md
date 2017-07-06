## 索引
1. 没有索引, mongodb会进行全collection扫描
2. 默认创建_id unique 索引, 并且无法删除
3. mongodb 默认使用B-Tree索引
4. Hash索引, 不支持range-base查询, 只支持相等查询
5. 不能在已经有重复值的field创建unique index
6. hash索引不能是unique的
7. 如果一个document不包含被索引的field, 则会被记录为null, 如果有unique限制, 后续的记录会触发duplicate error
8. partial index 只对符合条件的一部分document的相关field做索引
9. sparse index 只对包含index field的document做索引, 因为不包含全部, 所以是稀疏的


索引属性
    unique
    partial
    sparse
    ttl

创建索引
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

列出索引
    db.col.getIndexes() --> {"name":"_id_"}

删除索引
    db.collection.dropIndex("_id_");
    

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

默认使用fs.files,来存储元数据,  fs.chunks来存储文件的chunk, fs为前缀

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
        --prefix=<prefix> GridFS前缀, 默认为fs


查询文件元数据
    >db.fs.files.find()
    {
       _id: ObjectId('534a811bf8b4aa4d33fdf94d'),
       filename: "song.mp3",
       chunkSize: 261120,
       uploadDate: new Date(1397391643474), md5: "e4f53379c909f7bed2e9d631e15c1c41",
       length: 10401959
    }

    >db.fs.chunks.find({files_id: ObjectId('534a811bf8b4aa4d33fdf94d')})

```

## "config" database

1. 用来保存分片集群信息并进行分片集群的操作, 最好不要插入其他数据
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


## "local" database
```
所有在local库的collection都不会被复制
local库可以用来存储自身特有的数据, 或者与复制有关的数据

local.startup_log
local.system.replset
local.oplog.rs
local.replset.minvalid
local.slaves
```

### 多collection关联
```
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
... $id: 1
... }}
localhost(mongod-3.2.3) new> db.post.insert(p)

db.post.findOne().author.fetch()

```

### 修改replset优先级
```
cfg = rs.conf()
cfg.members[0].priority = 0.5
cfg.members[1].priority = 2
cfg.members[2].priority = 2
rs.reconfig(cfg)
```

## 经验
```
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

```

