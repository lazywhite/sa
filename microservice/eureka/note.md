## Introduction
Eureka is a REST based service that is primarily used for the purpose of 
"service register", "load balancing", "failover"  

## Component
```
server
client
    built-in load balancer does only basic round-robin load balancing
    Hystrix wrapped client provide "weighted" load balancing based on 
        traffic
        resource usage
        error condition
```
## Typical usage
```
application service
    eureka client
application client
    eureka client
eureka cluster
    eureka server replica set
```
## Topic
1. services register with Eureka and send heartbeats to renew state in 30 seconds interval    
2. application client use eureka client to get services location from eureka server, then make remote call to them

