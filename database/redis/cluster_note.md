## Concept
redis cluster provides a way to run a redis installation where data is automatically sharded across multiple redis nodes;

redis cluster also provides some degree of availability during partitions, that is
practical terms the ability to continue the operations when some nodes fail or 
are not able to communicate. 

the ability to automatically split your dataset among multiple nodes;
the ability to continue operations when a subset of the nodes are experiencing failure or are unable to communicate with the rest of the cluster

## Redis cluster Goals
1. high performance and linear scalability up to 1000 nodes, there are no
proxies, asynchronous replication is used, and no merge operations are performed
on values
2. Acceptable degree of write safety. 
3. Availability: redis cluster is able to survive partitions where the majority of
the master nodes are reachable and there is at least one reachable slave for every
master node that is no longer reachable.

## redis cluster tcp ports

every redis cluster node requires two tcp connection open,
    
    6379: the normal redis tcp port used to serve clients, 
    16379: the port obtained by adding 10000 to the data port


this second high port is to used for the cluster bus, that is a node-to-node communication channel using a binary protocol. the cluster bus is used by nodes for failure
detection, configuration update, failover authorization and so forth. 
clients should never try to communicate with the cluster bus port, but always with
the normal redis command port. 

### Write safety
Redis Cluster uses asynchronous replication between nodes,  and last failover wins implicit merge function

## redis cluster and docker
currently redis cluster does not support NATed environments and in general environments where IP addresses or TCP ports are remapped

Docker uses a technique called "port mapping", programs running inside Docker containers may be exposed with a different port compared to the one the program believes to be using. 


## redis cluster data sharding
redis cluster does not use consistent hashing, but a different form of sharding 
where every key is conceptually part of what we call an "hash slot".

there are "16384"(2 ** 14) hash slots in redis cluster, and to compute what is the hash slot
of a given key, we simply take the CRC16 of the key modulo 16384;

every node in a redis cluster is reponsible for a subset of the hash slots;


moving hash slots from a node to another does not require to stop operations, adding 
and removing nodes, or changing the percentage of hash slots hold by nodes, does
not require any downtime.

redis cluster supports multiple key operations as long as all the keys involved into 
a single command execution all belong to the same hash slot. the user can force multiple keys to be part of he same hash slot by using a concept called "hash tags"

Hash tags are documented in the Redis cluster specification, but the gist is that 
if there is a substring between {} brackets in a key. only what is inside the string
is hashed, so for example this {foo} key and another {bar} key are guaranteed to be 
in the same hash slot, and can be used together in a command with multiple keys as arguments


## Redirection and Resharding
"MOVED" Redirection
a redis client is free to send queries to every node in the cluster, including slave
nodes, the node will analyze the query, and if it is acceptable(that is, only a 
single key is mentioned in the query, or the multiple keys mentioned are all to 
the same hash slot) it will lookup what node is responsible for the hash slot where
the key or keys belong.

if the hash slot is served by the node, the query is simply processed, otherwise
the node will check its internal hash slot to node map, and will reply to the client
with a "MOVED" error, the error includes the hash slot of the key(3999) and the 
ip:port of the instance that can serve the query. 


## Tips
### cluster status 
只有两种状态: FAIL, OK
即使集群中只有一部分hash slot不能使用, 集群也会停止处理任何命令

集群进入FAIL状态的两种情况
1. 至少有一个hash slot不能使用
2. 集群中大部分master节点都进入PFAIL状态, 集群也会进入FAIL状态

### 从节点选举
一旦某个主节点进入 FAIL 状态， 如果这个主节点有一个或多个从节点存在， 那么其中一个从节点会被升级为新的主节点， 而其他从节点则会开始对这个新的主节点进行复制。

在集群的生命周期中， 如果一个带有 PROMOTED 标识的主节点因为某些原因转变成了从节点， 那么该节点将丢失它所带有的 PROMOTED 标识。

### 发布订阅
在一个 Redis 集群中， 客户端可以订阅任意一个节点， 也可以向任意一个节点发送信息， 节点会对客户端所发送的信息进行转发。

### shutdown server
```
redis-cli>shutdown
```
