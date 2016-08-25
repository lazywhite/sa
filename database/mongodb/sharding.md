# Topic
## shard key
to shard a cluster, you need a shard key, A shard key is a indexed field or 
an indexed compound field that existed in every document in the collection

compound index: db.collection.createIndex( { <field1>: <type>, <field2>: <type2>, ... } )

MongoDB divides the shard key values into chunks and distributes the chunks
evenly across the shards. To divide the shard key values into chunks, MongoDB
uses either "range based partitioning" or "hash based partitioning".

MongoDB partitions data in the collection using ranges of shard key values.
Each range defines a non-overlapping range of shard key values and is associated with a chunk.

MongoDB attempts to distribute chunks evenly among the shards in the cluster. 
The shard key has a direct relationship to the effectiveness of chunk distribution

once you shard a collection, the shard key and the value are immutable
1. you can not select a different shard key for that collection
2. you can not update the values of the shard key fields

if you shard an empty collection using a hashed shard key, MongoDB automatically
creates two empty chunks per shard, parameter "numInitialChunks" can control how many chunks create;

## tag aware sharding
in sharded cluster, you can tag specific ranges of the shard key and associate
those tags with a shard or suset of shards, Mongodb routes reads and writes that
fail into a tagged range only to those shards configured for the tag

## how to shard a collection
```
1. database must have sharding enabled 'sh.enableSharding("<database>")'
2. connect to "mongos" instance
3. if collection is not empty, you must create index on the "shard key" using
"db.collection.createIndex()" before using "sh.shardCollection()"
create a hashed index: 'db.collection.createIndex( { _id: "hashed" } )'
create a ranged index: 'db.collection.createIndex( { _id: 1 } )'
do not use a hashed index for floating point numbers
4. if collection is empty, mongodb create index as part of "sh.shardCollection(namespace, {key: direction})"
```


## routing process

### how mongos determine which shards receive a query
a "mongos" instance routes a query to a cluter by:
    1. determining the list of shards that must receive the query
    2. establishing a cursor on all targeted shards

in some case, when the shard key or a prefix of the shard key is a part of 
the query, the mongos can route the query to a subset of the shards, otherwise
the mongos must direct the query to all shards that hold documents for that collection

### how mongos handles query modifier
if the result of the query is not sorted, the mongos instance open a result cursor
that "round robin" result from all cursors on the shards.


if the query specifies sorted results using the "sort()" cursor method, the mongos
instance passes the $orderby option to the shards. the primary shard for the 
database receives and perform a "merge sort" for all  results before returning the
data to the client via the "mongos"

if the query limits the size of the result set using "limit()" cursor method
the mongos instances pass that limit to the shards and then re-applies the limit
to the result before returning the result to client;

if the query specifies a number of records to skip using "skip()" cursor method, 
the "mongos" cannot pass the skip to the shards, but rather retrieves unskipped
result from the shards and skips the appropriate number of documents when 
assembling the complete result. however, when used in conjunction with a "limit()"
the mongos will pass the limit plus the value of skip() to the shards to improve
the efficiency of these operations


## broadcaset operations and targeted operations
in general, operations in a sharded environment are either:
1. broadcaset to all shards in the cluster that hold documents in a collection
2. targeted at a single shard or a limited group of shards, base on "shard key"

### broadcast operations
mongos instances broadcast queries to all shards for the collection unless the 
mongos can determine which shard or shard group stores the data;

"multi-update" operations are always broadcaset operations

the "remove()" operation is always a broadcast operation, unless the operation
specified the shard key in full;

### targed operations
1. all "insert()" operations target to one shard
2. all single "update()", including upsert operations and "remove()" operations must
3. for queries that include the shard key or portion of the shard key, "mongos" can
target the query at a specified shard or set of shards. this is the case only if 
the portion of the shard key included in the query is a prefix of the shard key;

## shard and non-shard data
"sharding operates on the collection level" , in production, you can shard multiple
collections within a database or have multiple databases sharding enabled

regardless of the data architecture of your sharded cluster, ensure that all query
and operations using "mongos" router to access the data cluster.


## Shard balancing
balancing is the process Mongodb uses to distribute data of a sharded collection 
evenly across a sharded cluster

### clusetr balancer
the "balancer" process is responsible for redistributing the chunks of a sharded
collections evenly among the shards for every sharded collection, by default the 
"balancer" process is always enabled;

any "mongos" instance in the cluster can start a balancing round, when a balancer
process is active, the responsible "mongos" acquires a "lock" by modifying a 
document in the "lock" collection of "config" database

chunk migrations carry some overhead in terms of bandwidth and workload, both of 
which can impact database performance, the balance attempts to minimize the impact
by "moving only one chunk a time", "start balancing round only when the difference
in the number of chunks between the shard with the greatest number of chunks for 
a sharded collection and the shard with the lowest number of chunks for that 
collection reaches the migration threshold", "limit the window during which the 
balancer runs to prevent it from impacting production traffic"

once a balancing round starts, the balancer will not stop until, for the collection
the difference between largest and smallest is less than "two", or a chunk migration fails;

base on difference between biggest and smalles chunks, different number of threads
are used to migrate

### chunk migration
```
1. The balancer process sends the moveChunk command to the source shard.
2. The source starts the move with an internal moveChunk command. During the migration process, operations to the chunk route to the source shard. The source shard is responsible for incoming write operations for the chunk.
3. The destination shard builds any indexes required by the source that do not exist on the destination.
4. The destination shard begins requesting documents in the chunk and starts receiving copies of the data.
5. After receiving the final document in the chunk, the destination shard starts a synchronization process to ensure that it has the changes to the migrated documents that occurred during the migration.
6. When fully synchronized, the destination shard connects to the config database and updates the cluster metadata with the new location for the chunk.
7. After the destination shard completes the update of the metadata, and once there are no open cursors on the chunk, the source shard deletes its copy of the documents.
```

### shard size
by default mongodb will attempt to fill all available disk space with data on every
shard as the data set grows. when add a shard, you may set a "maximum size" for that
shard. 

### chunk size
default 64MB, if automatic migrations have more I/O than your hardware can handle, 
you can reduce the chunk size, a small chunk size leads to more repid and frequent 
migrations, the allowed range of chunk size is between 1 and 1024 MB.   

```
1. connect to any "mongos" 
2. use config
3. db.settings.save({_id:"chunksize", value: <size in MB> })
```

