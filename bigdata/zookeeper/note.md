## Introduction
为分布式应用提供协调服务, 自身也是分布式集群,  集群分为leader, follower两种角色, client可以跟任何server进行通信  
主要基于观察者模式工作


## Keyword
```
znode: 
    类型(默认是persistent node)
        ephemeral node
            临时节点, session关闭就会被删除
        sequential node
            名称后面有10位的数字
            如果并发创建, zookeeper保证数字不会重复
            常用在锁与同步中
            不同类型的znode都可以是普通或顺序型的
     
	version number: 每当znode有更改, 版本号会递增
	ACL: 每个znode可以设置权限
	Timestamp
		created: 创建时间戳
		modified: 更改时间戳
	Data length: 数据长度
	Children: 子节点数目
	
ensemble(server group)
    server
        leader  
        follower  

watch: 事件通知机制

ACL
    scheme
        world
            只有一个id: anyone, 
        auth
            无需id, 只要通过authentication的user都有权限
        digest
            id为 username:BASE64(sha1(password)), 需要先通过authentication
        ip
            id为一个网段或单个ip
        super
    id
    permission
        create(c)
        delete(d)
        read(r)
        write(w)
        admin(a)
集群通信
    Zab protocol
```



## 使用场景
### 1. Name Service
将zookeeper中一个全局唯一的path映射给一个节点, 达到命名的目的
### 2. 配置管理
所有server在同一个znode上调用getData(watches), 一旦znode data发生变化, 所有server将会得到通知, 从而拉取最新的配置  
### 3. leader选举流程
```
所有节点在同一个目录创建一个sequential ephemeral类型的znode, 由zookeeper ensemble 来保证节点的唯一性
哪个节点创建的znode末尾的数字最小, 就成为集群的leader, 其他成为follower
如果leader宕机, 与它对应的sequential ephemeral node会被删除, 
每个node都会检测比自己小1的znode, 集群将会选取拥有最小znode的server作为leader
```
### 4. 分布式锁
```
独占锁: 竞争锁
    所有client都去创建/distribute_lock, 成功创建的就视为拿到锁, 释放时删除节点即可
有序锁: 所有来获取锁的, 最终会按照顺序拿到锁
    所有client都在/distribute_lock下创建sequential ephemeral node, 最终可按照znode的大小进行排序
    
```
### 5. 队列管理
```
同步队列    
    一个大任务, 需要在很多小任务执行完毕时才能执行, 可以让小任务完毕后在/sync_queue/注册一个sequential ephemeral node 
    大任务通过watch获取/sync_queue下面节点的数量, 满足条件即可执行
FIFO队列   
    跟有序锁实现思路相同
```
### 6. 负载均衡
```
生产者负载均衡
消费者负载均衡
```
    

## 结论
1. node data被更新, dataVersion将会增加1
2. 每个znode默认可存储1MB的数据
3. 每个与server建立连接的client, 将会得到一个session id, 同一个session发送的请求将会以FIFO的方式执行
client会发送heartbeat来保持session, server在session timeout后会删除跟session关联的所有ephemeral node
4. client可以注册watcher来得到关于znode或其children的 znode data变化的事件, 从而采取动作
5. znode acl无法继承, 只能针对每一个znode设置acl
6. znode quota 支持node数目(包括自身), data size (in bytes)设置, 若超限还是会正常执行, zookeeper.log将会有quota exceeded提示
