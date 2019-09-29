## single node Installation and Usage
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
    kafka-console-consumer.sh --zookeeper localhost:2181 --topic test --from-beginning --max-messages 100
8. start other broker
    cp config/server.properties config/server-1.properties
    config/server-1.properties:
        broker.id=1
        port=9093
        log.dir=/tmp/kafka-logs-1
    kafka-server-start.sh config/server-1.properties

9. modify a topic
    kafka-topics.sh --zookeeper localhost:2181 --alter --topic Hello-kafka --partitions 2
10. delete a topic
    kafka-topics.sh --zookeeper localhost:2181 --delete --topic topic_name

Kafka在0.9之前是基于Zookeeper来存储Partition的Offset信息(consumers/{group}/offsets/{topic}/{partition})
因为ZK并不适用于频繁的写操作，所以在0.9之后通过内置Topic(__consumer_offset)的方式来记录对应Partition的Offset。

11. 查看consumer group详情
    新版
        kafka-consumer-groups.sh --new-consumer --bootstrap-server 127.0.0.1:9292 --group lx_test --describe
    老版
        kafka-consumer-groups.sh --zookeeper localhost:2181 --group my-group --describe 
12. 查看consumer group列表
    新版(信息保存在broker中)
        kafka-consumer-groups.sh --new-consumer --bootstrap-server 127.0.0.1:9292 --list
    老版(信息保存在zookeeper中)
        kafka-consumer-groups.sh --zookeeper 127.0.0.1:2181 --list

13. topic rebalance
https://blog.imaginea.com/how-to-rebalance-topics-in-kafka-cluster/

(1). 节点宕机后又上线
    查看
        kafka-topics.sh --describe --zookeeper localhost:2181 --topic test
    关闭自动平衡(有bug)
        server.properties
            auto.leader.rebalance.enable = false
    手动平衡
        bin/kafka-preferred-replica-election.sh --zookeeper zoo1:2181,zoo2:2181,zoo3:2181
(2). 节点宕机后没有上线
新增一台机器, 配置server.id, 然后kafka-preferred-replica-election.sh
(3). 新增或剔除节点
根据需要调整的topic生成配置 topics-to-move.sh
    {"topics":
        [{"topic":"testMcdull"}],
        "version": 1
    }

生成重分配计划
    kafka-reassign-partitions.sh --zookeeper zoo1:2181 --topics-to-move-json-file topics-to-move.json [--broker-list "2,3"] --generate
    结果保存在reassign.json
执行重分配
    kafka-reassign-partition.sh --zookeeper zoo1:2181 --reassignment-json-file reassign.json –execute 

验证重分配
    kafka-reassign-partition.sh --zookeeper zoo1:2181 --reassignment-json-file reassign.json –verify  
执行平衡
    bin/kafka-preferred-replica-election.sh --zookeeper zoo1:2181,zoo2:2181,zoo3:2181

```

