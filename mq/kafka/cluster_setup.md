1. 確保已有zookeeper集群运行
2. 每个节点创建如下配置, 确保broker.id唯一
    如果在同一台机器, 要指定端口listeners=PLAINTEXT://:9094
    指定不同的log.dirs
    无需指定其他的broker, 通过zookeeper进行协调
config/server.properties
    broker.id=0
    num.network.threads=3
    num.io.threads=8
    socket.send.buffer.bytes=102400
    socket.receive.buffer.bytes=102400
    socket.request.max.bytes=104857600
    log.dirs=/var/log/kafka
    num.partitions=3
    num.recovery.threads.per.data.dir=1
    offsets.topic.replication.factor=1
    transaction.state.log.replication.factor=1
    transaction.state.log.min.isr=1
    log.retention.hours=168
    log.segment.bytes=1073741824
    log.retention.check.interval.ms=300000
    zookeeper.connect=zoo1:2181,zoo2:2181,zoo2:2181
    zookeeper.connection.timeout.ms=6000
    group.initial.rebalance.delay.ms=0

3. kafka把接受到的消息存储在log.dirs
4. kafka-server-start.sh -daemon connfig/server.properties # 后台运行
5. zookeeper-cli>get /broker/ids  # 获取broker列表
