# Keyword
```
AMQP
    1. vhost: namespace of resource
    2. exchange
    3. queue
    3. binding

exchange type
    1. base on routing key
        fanout
        direct
        topic
        
    2. base on routing value
        header

binding
    exchange --> exchange
    queue --> exchange

processing
    rpc
    polling
    delay
    queue-length-limit

concept
    cluster
    HA
    management
    vhost
    http-api
```

# Commands
```
rabbitmqctl list_users
rabbitmqctl list_permissions -p /
rabbitmqctl list_user_permissions guest
rabbitmqctl add_user admin admin@mmbang
rabbitmqctl set_user_tags admin administrator
rabbitmqctl list_user_permissions guest
rabbitmqctl set_permissions admin ".*" ".*" ".*"
rabbitmqctl delete_user guest
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


# Topic 
1. you can bind one queue and one exchange  with many routing key  

2. AMQP 0-9-1, messages are load balanced between consumers.  

3. If a consumer determines that it cannot handle a message then it can reject it using basic.reject (or basic.nack), either asking the server to requeue it  

4. if hostname -s is not resolvable, rabbitmq-server will refuse to start

## add consistant-hash-exchange support 
```
git clone  https://github.com/rabbitmq/rabbitmq-consistent-hash-exchange; make
rabbitmq-plugins enable rabbitmq_consistent_hash_exchange

```