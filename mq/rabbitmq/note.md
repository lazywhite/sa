1. consumer prefetch
2. you can bind one queue and one exchange  with many routing key



Messages That Cannot Be Processed
If a consumer determines that it cannot handle a message then it can 
reject it using basic.reject (or basic.nack), either asking the server to requeue it

AMQP 0-9-1, messages are load balanced between consumers.

if hostname -s is not resolvable, rabbitmq-server will refuse to start
