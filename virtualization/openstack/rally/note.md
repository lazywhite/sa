## Introduction
Rally is a benchmarking tool for openstack, It has following features  
1. deploy openstack using devstack, fuel etc..
2. verify openstack components function using "tempest"
3. benchmark&profiling openstack components
4. generating report 


## Architecture
Rally component
    Server Providers
        provide servers(virtual servers), with ssh access, in one L3 network
    Deploy Engine
        deploy openstack cloud on servers that are presented by "Server Providers" 
    Verification 
        run "tempest" against a deployed cloud
    Benchmarking engine
        allow to write parameterized benchmark scenarios & run them against the cloud
Rally web
    message queue
    RPC
Rally App
    cli
    manager orchestrator
    database
    

## Keyword
```
Task & subtask
    args
    runner
        type
            constant
            constant_for_duration
            periodic
            serial
        times
        concurrent
    context: define environment which scenarios should be launched in
        users
            tenants
            users_per_tenant
        quotas
            nova
                intances
    cleanup


rally config(configparser format)
    ~/.rally/rally.conf  
    /etc/rally/rally.conf

rally db
    mysql/postgresql

alembic
    db migration tool
plugin
    scenarios, runners, context, html report all are pluggable
```


openstack image list
openstack host list
openstack network list
openstack router list
