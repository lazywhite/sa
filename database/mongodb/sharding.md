# Topic
## shard key
to shard a cluster, you need a shard key, A shard key is a indexed field or 
an indexed compound field that existed in every document in the collection


MongoDB divides the shard key values into chunks and distributes the chunks
evenly across the shards. To divide the shard key values into chunks, MongoDB
uses either "range based partitioning" or "hash based partitioning".

## compound keys 
db.collection.createIndex( { <field1>: <type>, <field2>: <type2>, ... } )
