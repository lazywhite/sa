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
