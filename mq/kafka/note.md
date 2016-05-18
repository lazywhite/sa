## Document
[kafka key concept](http://www.javali.org/bigdata/kafka-key-concepts-docs-html.html )

## Topic
compress_type 
send(key)
group_id
client_id
dump log file
consumer auto commit
partition_assignment_strategy
mirror data between cluster
get topic partition information

## ecosystem
kafka connect
    writing or exporting data from kafka
stream processing
hadoop integration
elasticsearch
hive
kafka-manager
    manage tool
AWS
logging
ganglia integration



## Commands

kafka-topics.sh --zookeeper localhost:2181 --alter --topic test --partitions 2

kafka-console-consumer.sh --zookeeper localhost:2181 --topic test --consumer.config /usr/local/etc/kafka/consumer.properties


## tutorial
1. start zookeeper
    zookeeper-server-start.sh config/zookeeper.properties
2. configure config/server.properties
    host.name = localhost
3. start kafka broker
    kafka-server-start.sh config/server.properties
4. create a topic
    kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test
5. show topic info
    kafka-topics.sh --list --zookeeper localhost:2181
    kafka-topics.sh --describe --zookeeper localhost:2181 --topic test
6. send message
    kafka-console-producer.sh --broker-list localhost:9092 --topic test   
7. recv message
    kafka-console-consumer.sh --zookeeper localhost:2181 --topic test --from-beginning
8. start other broker
    cp config/server.properties config/server-1.properties
config/server-1.properties:
    broker.id=1
    port=9093
    log.dir=/tmp/kafka-logs-1


## concept
1.Topics

A stream of messages belonging to a particular category is called a topic. Data is stored in topics.

Topics are split into partitions. For each topic, Kafka keeps a mini-mum of one partition. Each such partition contains messages in an immutable ordered sequence. A partition is implemented as a set of segment files of equal sizes.

2.Partition

Topics may have many partitions, so it can handle an arbitrary amount of data.

3.Partition offset

Each partitioned message has a unique sequence id called as offset.

4.Replicas of partition

Replicas are nothing but backups of a partition. Replicas are never read or write data. They are used to prevent data loss.

5.Brokers

Brokers are simple system responsible for maintaining the pub-lished data. Each broker may have zero or more partitions per topic. Assume, if there are N partitions in a topic and N number of brokers, each broker will have one partition.

Assume if there are N partitions in a topic and more than N brokers (n + m), the first N broker will have one partition and the next M broker will not have any partition for that particular topic.

Assume if there are N partitions in a topic and less than N brokers (n-m), each broker will have one or more partition sharing among them. This scenario is not recommended due to unequal load distri-bution among the broker.

6.Kafka Cluster

Kafka’s having more than one broker are called as Kafka cluster. A Kafka cluster can be expanded without downtime. These clusters are used to manage the persistence and replication of message data.

7.Producers

Producers are the publisher of messages to one or more Kafka topics. Producers send data to Kafka brokers. Every time a producer pub-lishes a message to a broker, the broker simply appends the message to the last segment file. Actually, the message will be appended to a partition. Producer can also send messages to a partition of their choice.

8.Consumers

Consumers read data from brokers. Consumers subscribes to one or more topics and consume published messages by pulling data from the brokers.

9.Leader

Leader is the node responsible for all reads and writes for the given partition. Every partition has one server acting as a leader.

10.Follower

Node which follows leader instructions are called as follower. If the leader fails, one of the follower will automatically become the new leader. A follower acts as normal consumer, pulls messages and up-dates its own data store.
