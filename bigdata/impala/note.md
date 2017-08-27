## Introduction
```
impala可以操作存储在Hbase或HDFS中PB级的数据, 提供SQL接口, 并具有几乎实时的操作性能
提供Hue browser web页面进行操作  
特点:
    1. 不需要把中间结果写入磁盘, 节省大量IO开销
    2. 省掉MapReduce作业启动的开销, 直接用服务进程进行作业调度
    3. 抛弃mapreduce, 使用MPP(massive parallel processing)进行计算
    4. 使用LLVM编译代码, 避免了为支持通用编译带来的开销
    5. 使用C++开发, 有很多针对硬件的优化, 如支持SSE指令集
    6. 使用了支持Data locality的I/O调度机制，尽可能地将数据和计算分配在同一台机器上进行，减少了网络开销
```
## Architecture
```
主要组件
    impalad: 运行在所有节点, 负责执行从Hue, Impala Shell, JDBC发送过来的命令并进行处理
        query planner
        query coordinator
        query exec engine
    statestore: nameing service, 负责impalad的位置监测和健康状态监测
    catalogd: 元数据协调服务, 将DML, DDL带来的元数据改变通知给所有节点
    metastore: mysql/postgresql等存储表元数据的数据库, 除此之外每个节点还会在本机缓存所有的元数据
```

## Installation
```
1. 在每个datanode安装impalad, 需要全部运行
2. 在namenode安装statestored, 仅运行一个
3. 在集群中运行一个catalogd, 最好跟statestored运行在一起
4. 在任意节点安装impala-shell, 甚至可以不在集群内部, 只要能连接到任意一个impalad
```
