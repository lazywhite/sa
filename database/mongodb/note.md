## Caped collections
"capped collection" are fixed-size collections that support high-throughput
operations that insert and retrive documents based on insertion order.
capped collections work in a way similar to circular buffers; once a collection
fills its allocated space, it makes room for new documents by overrwriting the 
oldest document of the collection


```
1. create capped collection
>db.createCollection("cappedLogCollection",{capped:true,size:10000})
还可以指定文档个数,加上max:1000属性：
>db.createCollection("cappedLogCollection",{capped:true,size:10000,max:1000})

判断集合是否为固定集合:
>db.cappedLogCollection.isCapped()
j
如果需要将已存在的集合转换为固定集合可以使用以下命令：
>db.runCommand({"convertToCapped":"posts",size:10000})

固定集合查询
固定集合文档按照插入顺序储存的,默认情况下查询就是按照插入顺序返回的,也可以使用$natural调整返回顺序。
>db.cappedLogCollection.find().sort({$natural:-1})

固定集合的功能特点
可以插入及更新,但更新不能超出collection的大小,否则更新失败,不允许删除,但是可以调用drop()删除集合中的所有行,但是drop后需要显式地重建集合。

在32位机子上一个cappped collection的最大值约为482.5M,64位上只受系统文件大小的限制。
```

## GridFS 
```
mongofiles -d gridfs put song.mp3
>db.fs.files.find()

```

## shard collection balancing
```

In MongoDB when you go to a sharded system and you don't see any balancing it could one of several things.

You may not have enough data to trigger balancing. That was definitely not your situation but some people may not realize that with default chunk size of 64MB it might take a while of inserting data before there is enough to split and balance some of it to other chunks.
The balancer may not have been running - since your other collections were getting balanced that was unlikely in your case unless this collection was sharded last after the balancer was stopped for some reason.
The chunks in your collection can't be moved. This can happen when the shard key is not granular enough to split the data into small enough chunks. As it turns out this was your case because your shard key turned out not to be granular enough for this large a collection - you have 105 chunks (which probably corresponds to the number of unique job_id values) and over 30GB of data. When the chunks are too large and the balancer can't move them it tags them as "jumbo" (so it won't spin its wheels trying to migrate them).
How to recover from a poor choice of a shard key? Normally it's very painful to change the shard key - since shard key is immutable you have to do an equivalent of a full data migration to get it into a collection with another shard key. However, in your case the collection is all on one shard still, so it should be relatively easy to "unshard" the collection and reshard it with a new shard key. Because the number of job_ids is relatively small I would recommend using a regular index to shard on job_id,customer_code since you probably query on that and I'm guessing it's always set at document creation time.

```


## Mongodb WiredTiger max cache size
```
mongod.conf
    wiredTigerCacheSizeGB = 1
    
```



## "config" database

1. the config database supports "sharded cluster" operations
2. to access "config" database, connect to "mongos" instance in a shard cluster,
 
### "config" database collections

```
config.change_log
config.chunks
config.collections
config.databases
config.lockpings
config.locks
config.mongos
config.settings
config.shards
config.tags
config.version
```


## "local" database
every mongod instance  has its own "local" database, which store data used in 
the replication process and other instance-specified data. the "local" database
in invisible to replication: collections in the local database are not replicated

```
local.startup_log
local.system.replset
local.oplog.rs
local.replset.minvalid
local.slaves
```


### collections used in Master/Slave replication
```
on the master
    local.oplog.$main
    local.slaves

on each slave
    local.sources

```

## Tips
### show collection information 
```
db.col.getShardDistribution() # show sharded collection distribution information

db.col.stats() #  size in mem
db.col.storageSize() # physical size 
```

### 修改replset优先级
```
cfg = rs.conf()
cfg.members[0].priority = 0.5
cfg.members[1].priority = 2
cfg.members[2].priority = 2
rs.reconfig(cfg)
```

### user manipulate
```
1. you can not create user on the "local" database
2. to create a new user in a database, you must have the "creatUser action" on 
that database resource
3. to grant roles to a user, you must have the "grantRole action" on the role's database
4. the "userAdmin" and "userAdminAnyDatabase" built-in roles provide "createUser" and "grantRole" actions on their respective resource
db.createUser(user: document, writeConcern: document)

user documetn:
    user: string
    pwd: string
    customData: document
    roles: array

roles: [ "readWrite", "dbAdmin" ]
roles: [
        { role: "readWrite", db: "config" },
        "clusterAdmin"
        ]
    }
```

## detect if connecting with a "mongos" instannce
```
use admin
db.isMaster() --> "msg": "isdbgrid" ## show it is mongos otherwise not
```
