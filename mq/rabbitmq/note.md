# Keyword
```
AMQP
    1. vhost: namespace of resource
    2. exchange
    3. queue
    3. binding

exchange type
    1. base on routing key
        default
        fanout
        direct
        topic
        
    2. base on routing value
        header

binding
    均为单向
    exchange --> exchange
        exchange.bind(src, dest, routing_key)
    queue --> exchange
        queue.bind(exchange, routing_key)

plugins
    rabbitmq_management
        管理插件, 可用在单节点
        使rabbitmq支持http-api
        localhost:15672   guest:guest
    rabbitmq_management_agent
        集群安装rabbitmq_management时的依赖
    rabbitmq_federation
        跨WAN的集群复制
    rabbitmq_federation_management
        rabbitmq_management的插件, 提供federation status
    rabbitmq_mqtt
        mqtt协议支持
    rabbitmq_stomp
        stomp协议支持

default port
    4369 (epmd)
    25672 (Erlang distribution)
    5672, 5671 (AMQP 0-9-1 without and with TLS)
    15672 (if management plugin is enabled)
    61613, 61614 (if STOMP is enabled)
    1883, 8883 (if MQTT is enabled)

processing
    rpc: 一去一回
    polling: 一去多回

queue mirroring mode
    ha-mode
        all: 所有node全部复制, 新加进集群的也会自动复制
        exactly: 指定镜像的个数, 如果一个node下线, 将会在新node做镜像
        nodes: 指定做镜像的node name (rabbit@node1)列表

cluster
    broker
        vhost
channel
    在一个连接中可以建立多个channel

role
    none
    management
    admin
    monitoring
    policymaker
```

# Commands
```
rabbitmqctl list_users
rabbitmqctl list_permissions -p /
rabbitmqctl add_user admin admin@mmbang
rabbitmqctl set_user_tags admin administrator
rabbitmqctl list_user_permissions guest
rabbitmqctl set_permissions admin ".*" ".*" ".*"
rabbitmqctl delete_user guest
rabbitmqctl change_password <username> <newpassword>
rabbitmqctl clear_password <username>

rabbitmqctl add_vhost <vhost>
rabbitmqctl delete_vhost <vhost>
rabbitmqctl list_vhosts [<vhostinfoitem> ...]

rabbitmqctl list_policies [-p <vhost>]
rabbitmqctl set_policy [-p <vhost>] [--priority <priority>] [--apply-to <apply-to>]
rabbitmqctl <name> <pattern>  <definition>
rabbitmqctl clear_policy [-p <vhost>] <name>

rabbitmqctl list_queues [-p <vhost>] [--offline|--online|--local] [<queueinfoitem> ...]
rabbitmqctl list_exchanges [-p <vhost>] [<exchangeinfoitem> ...]
rabbitmqctl list_bindings [-p <vhost>] [<bindinginfoitem> ...]
rabbitmqctl list_connections [<connectioninfoitem> ...]
rabbitmqctl list_channels [<channelinfoitem> ...]
rabbitmqctl list_consumers [-p <vhost>]
```



## Python library
```
publisher:
    connection = Connection(host='', port='')
    channel = connection.channel()
    channel.exchange_declare(exchange='name', type='type')
    channel.basic_publish(exchange='', routing_key='', body='')

consumer:
    connection = Connection(host='', port='')
    channel = connection.channel()
    result = channel.queue_declare(exclusive=True)
    queuename = result.method.queue
    queue_bind(exchange=exchange, queue=queue_name, routing_key="key")
    channel.basic_consume(callback, queue='', no_ack=True)
    channel.start_consuming()
```

# Exchange type
## Default exchange 
The default exchange is a pre-declared direct exchange with no name, usually referred by the empty string "". When you use the defaule exchange, your message will be delivered to the queue with a name equal to the routing key of the message. Every queue is automatically bound to the default exchange with a routing key which is the same as the queue name

## Direct exchange
It is perfectly legal to bind multiple queues with the same binding key.


## Topic exchange
The routing patterns may contain an asterisk (“*”) to match a word in a specific position of the routing key (e.g. a routing pattern of "agreements.*.*.b.*" will only match routing keys where the first word is "agreements" and the fourth word is "b"). A pound symbol (“#”) indicates match on zero or more words (e.g. a routing pattern of "agreements.eu.berlin.#" matches any routing keys beginning with "agreements.eu.berlin").

## Fanout exchange
message is routed to all queues (Queue A, Queue B, Queue C) because all queues are bound to the exchange. Provided routing keys are ignored.


## Header exchange
Headers exchanges route based on arguments containing headers and optional values. 
Headers exchanges are very similar to topic exchanges but it routes based on header values instead of routing keys. 
A special argument named "x-match" tells if all headers must match or just one.


## Deadletter exchange
If no matching queue can be found for the message, the message will be silently dropped. RabbitMQ provid an AMQP extension known as the "Dead Letter Exchange" - the dead letter exchange provides functionality to capture messages that are not deliverable



## add consistant-hash-exchange support 
```
git clone  https://github.com/rabbitmq/rabbitmq-consistent-hash-exchange; make
rabbitmq-plugins enable rabbitmq_consistent_hash_exchange

用一致性哈希算法从exchange往binded queue发送消息

```
## add delayed_exchange 
```
A user can declare an exchange with the type x-delayed-message and then publish messages with the custom header x-delay expressing in milliseconds a delay time for the message. The message will be delivered to the respective queues after x-delay milliseconds.

1. download the plugin  and place in $RABBIT_HOME/plugins
2. rabbitmq-plugins enable rabbitmq_delayed_message_exchange
```
## queue mirroring
```
1. 必须在集群中使用
2. 默认情况下一个queue认为只存在集群中某个node上面, 通过复制可以实现queue mirroring
3. 每个mirroring queue由一个master和多个mirror组成, 如果master消失, 则最先被创建的mirror成为新的master
4. 发往queue master的消息被复制给所有的mirror, 消费者不论连接哪个node, 最终全部连接到master queue, mirror会跟随master把被消费过得消息丢弃, 
5. queue mirroring只增加了可用性, 不会进行负载均衡
```


## 集群搭建
```
1. make sure nodes have the same /var/lib/rabbitmq/.erlang.cookie
2. node2> rabbitmq-server -detached
3. node2> rabbitmqctl stop_app
4. node2> rabbitmqctl join_cluster rabbit@node1 -t disk
5. node2> rabbitmqctl start_app
6. rabbitmqctl cluster_status
```

## Federation
```
1. 如果要在一个cluster中使用federation, 需要在每个节点上都安装federation plugin
2. 可用TLS来加密federation的复制
3. upstream上需要存在跟federation queue/exchange同名的queue/exchange才会进行复制


启用plugin
    rabbitmq-plugins enable rabbitmq_federation
    rabbitmq-plugins enable rabbitmq_federation_management

federation概念
    upstreams: each upstream defines how to connect to another broker
        @name  upstream1
        @uri   amqp://ip:port
        @expire  360000ms
    upstream sets: 一组upstream
        有一个默认的"all" upstream set, 指本机定义的所有upstream
    policies: 规定哪些exchange/queue 开启federation功能

define an upstream
    rabbitmqctl set_parameter federation-upstream my-upstream \
    '{"uri":"amqp://server-name","expires":3600000}'

define a policy that will match built-in exchanges except "default" and use 
this upstream
    rabbitmqctl set_policy --apply-to exchanges federate-me "^amq\." \
    '{"federation-upstream-set":"all"}'

```

## 消息堆积
```
1.可能的原因
    consumer没有正确的ack
    consumer死机
2. 解决方法
    channel.basicQos(0, 1, false)
    如果不设置qos, 一旦consumer上限, 会接受到大量消息, 导致卡死
    发现消息堆积, 在设置qos的前提下, 多开几个consumer将消息全部正常消费即可
```

## 优先级队列
```
创建queue时, 声明优先级最大值
发送消息时, 给消息设置priority属性, 较大priority的message优先被推送给consumer
# 结论
1. 一个queue可以用多个routing_key跟同一个queue绑定
2. 消费同一个queue的consumer会自动负载均衡
3. 消费者可以用basic.reject, basic.nack来拒绝消费消息, 使消息requeue
4. hostname -s不可解析的话,  rabbitmq-server将无法启动
5. 集群中的exchange和binding可以认为在所有node都是可用的, queue不是
6. basic_consume(ack=true) 当消费者处理完消息并向server发送ack后, 消息才被删除
7. 添加queue出错, 可能是erlang 与rabbitmq版本不兼容导致
8. 如果开启了federation的exchange/queue 在upstream找不到同名的exchange/queue进行复制会报错



###  集群搭建流程
```
## 1.on node1  

yum install rabbitmq-server
scp /var/lib/rabbimq/.erlang.cookie  node2:/var/lib/rabbitmq
chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie
rabbitmq-server -detached   #all node
     
## 2.on node2  

rabbitmqctl  stop_app
rabbitmqctl  cluster --disc|ram  rabbit@node1
rabbitmqctl  start_app
```

## 清理rabbitmq
  
```
ps aux | grep epmd
ps aux | grep erl
rm -rf /var/lib/rabbitmq/mnesia/*
rm -r /var/lib/rabbitmq/erlang.dump  
```
    
## 监听本地网卡
```  
[root@192_168_183_7 ~]# cat /etc/rabbitmq/rabbitmq-env.conf 
export RABBITMQ_NODENAME=rabbit@192_168_183_7  
export RABBITMQ_NODE_IP_ADDRESS=192.168.183.7
export ERL_EPMD_ADDRESS=192.168.183.7
```
