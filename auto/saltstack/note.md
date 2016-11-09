## Remote Execution
```
salt '<target>' <function> [arguments...]
```
## Configuration Management
1. states
2. grains
3. pillars
4. renders

## Events
```
beacons: 
```
## Reactor
```
reactor:
```
## Orchestration
a kind of 'runner' to  apply 'function', 'state'

## Salt SSH
execute salt commands and states over ssh with-out installing a salt-minion 
   
```
/etc/salt/roster
    web1:
        host:
        user:
        password:
```
## Salt Cloud
provision systems on cloud hosts/hypervisors and immediately bring them under management    

```
/etc/salt/cloud
/etc/salt/cloud.providers.d/*.conf
/etc/salt/cloud.profiles.d/*.conf
```

## Salt Proxy Minion
proxy minions enables controlling devices that, for whatever reason, cannot run  
a proprietary OS, devices with limited CPU or memeoy, or devices that could run a  
minion but for security reasons, will not;   

## Salt Syndic

## Salt Virt
```
support core cloud operations
    virtual machine deployment
    inspection of deployed VMs
    Virtual machine migration
    Network profiling
    Automatic VM integration with all aspects of salt
    Image pre-seeding
```
## Salt runner
Salt runners are convenience applications executed with the salt-run command.  
Salt runners work similarly to Salt execution modules however they execute on the Salt master itself instead of remote Salt minions.  
A Salt runner can be a simple client call or a complex application.    

```
built-in runners  
    cache
    cloud
    ddns
    doc
    drac
    error
    fileserver
    git_pillar
    http
    jobs
    manager
    mine
    network
    pillar
    pkg
    queue
    reactor
    ssh
    state
    test
    thin
    virt
```

## Topic
1. salt-run is always executed on salt-master
2. salt-call is always executed on salt-minion  
3. salt-syndic not respond to test.ping  
4. salt-master can control minions in intranet  
5. use pgrep or pkill, not to use too many pipe  
6. only need to open 4505, 4506 for salt-master, no need for salt-minion



### pillar related
```
salt '*' saltutil.refresh_pillar 
salt '*' pillar.items
```

### cant get pillar setting from syndic node
must restart salt-master daemon, not salt-syndic daemon
