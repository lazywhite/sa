## Installation and Usage
```
1. start embbed zookeeper
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

    ## 添加发送key value
    kafka-console-producer.sh --broker-list localhost:9092 --topic test --property "parse.key=true" --property "key.separator=:"
7. recv message
    kafka-console-consumer.sh --zookeeper localhost:2181 --topic test --from-beginning
8. start other broker
    cp config/server.properties config/server-1.properties
config/server-1.properties:
    broker.id=1
    port=9093
    log.dir=/tmp/kafka-logs-1


```

