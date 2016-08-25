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
