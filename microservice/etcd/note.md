## Introduction
分布式, 强一致性键值存储, 为分布式系统提供"共享配置"和"服务发现"


## Keyword
```
cluster
    memeber
    status
CRUD
    put
    get
    delete
transactional write
watch
lease
distribute lock
election
migrate
auth

member
    follower
    condidate
    leader
Raft
    分布式一致性算法
        选举
        log replication
    http://thesecretlivesofdata.com/raft/
    election
        election timeout: the amount of time a follower waits until becoming a candidate. (150ms-300ms)
            After the election timeout the follower becomes a candidate and starts a new election term
        heartbeat timeout
            leader send "append entry" message

```
