## Cluster setup
```
1. make sure nodes have the same /var/lib/rabbitmq/.erlang.cookie
2. rabbitmq-server -detached
3. rabbitmqctl stop_app
4. rabbitmqctl join_cluster rabbit@node1 -t disk
5. rabbitmqctl start_app
6. rabbitmqctl cluster_status
```

## Clusters Federation
```
Clusters can be linked together with federation just as single brokers can. To summarise how clustering and federation interact:

You can define policies and parameters on any node in the downstream cluster; once defined on one node they will apply on all nodes.
Exchange federation links will start on any node in the downstream cluster. They will fail over to other nodes if the node they are running on crashes or stops.
Queue federation links will start on the same node as the downstream queue. If the downstream queue is mirrored, they will start on the same node as the master, and will be recreated on the same node as the new master if the node the existing master is running on crashes or stops.
To connect to an upstream cluster, you can specify multiple URIs in a single upstream. The federation link process will choose one of these URIs at random each time it attempts to connect.


rabbitmq-plugins enable rabbitmq_federation
rabbitmq-plugins enable rabbitmq_federation_management
```