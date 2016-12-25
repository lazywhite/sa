## Introduction
```
1. mainly used for service discovery & register  
2. characteristic
    service discovery
    health check
    key/value store
    distribute
        support for multi-datacenter
```
[architecture](https://www.consul.io/docs/internals/architecture.html)  
[doc](https://book-consul-guide.vnzmi.com/)    

## Installation
```
Mac
    brew install consul
```

## Keyword
```
agent
server
    leader
    follower
client
    forwards all RPCs to a server
datacenter
consensus
gossip

8500: http api 
8600: DNS query 
```
## Command Usage
```
consul
    agent               run a consul agent
    configtest          validate config file
    event               fire a new event
    exec                execute a command on consul nodes
    force-leave         force a member of the cluster to enter "leave" state
    info                provide debug information for operators
    join                tell "agent" to join cluster
    keygen              generate a new encryption keys
    keyring             manage gossip layer encryption keys
    leave               gracefully leaves the consul cluster and shuts down
    lock                execute a command holding a lock
    maint               controls node or service maintenance mode
    members             lists the member of a consul cluster
    monitor             stream logs from a consul agent
    reload              trigger the agent to reload configuration file
    rtt                 estimates network round trip  time between nodes
    version             prints the consul version
    watch               watch for changes in consul

```
## Quickstart
```
# consul agent -dev [-node <nodename>] //dev mode, default nodename is hostname
# consul members
    
# curl localhost:8500/v1/catalog/nodes

    [
        {
            "Node": "con",
            "Address": "127.0.0.1",
            "TaggedAddresses": {
                "lan": "127.0.0.1",
                "wan": "127.0.0.1"
            },
            "CreateIndex": 4,
            "ModifyIndex": 5
        }
    ]

# dig @127.0.0.1 -p 8600 <nodename>.node.consul

    ;; QUESTION SECTION:
    ;con.node.consul.       IN  A

    ;; ANSWER SECTION:
    con.node.consul.    0   IN  A   127.0.0.1

# cat web.json
    {"service": {"name": "web", "tags": ["rails"], "port": 80}}

# consul agent -dev -node con -config-dir /path/to/conf

# dig @127.0.0.1 -p 8600 web.service.consul #<servicename>.service.consul

    ;; QUESTION SECTION:
    ;web.service.consul.        IN  A

    ;; ANSWER SECTION:
    web.service.consul. 0   IN  A   127.0.0.1

# dig @127.0.0.1 -p 8600 rails.web.service.consul #<tagname>.<servicename>.service.consul

    ;; QUESTION SECTION:
    ;rails.web.service.consul.  IN  A

    ;; ANSWER SECTION:
    rails.web.service.consul. 0 IN  A   127.0.0.1


# curl localhost:8500/v1/catalog/service/web

[
    {
        "Node": "con",
        "Address": "127.0.0.1",
        "TaggedAddresses": {
            "lan": "127.0.0.1",
            "wan": "127.0.0.1"
        },
        "ServiceID": "web",
        "ServiceName": "web",
        "ServiceTags": [
            "rails"
        ],
        "ServiceAddress": "",
        "ServicePort": 80,
        "ServiceEnableTagOverride": false,
        "CreateIndex": 5,
        "ModifyIndex": 5
    }
]


# curl -XPUT -d 'test' http://localhost:8500/v1/kv/web/key1
# curl http://localhost:8500/v1/kv/web/key1
[
    {
        "LockIndex": 0,
        "Key": "web/key1",
        "Flags": 0,
        "Value": "dGVzdA==",
        "CreateIndex": 53,
        "ModifyIndex": 53
    }
]

# consul agent -dev -config-dir conf -node con -ui -data-dir data # web dashboard
http://localhost:8500/ui

```

