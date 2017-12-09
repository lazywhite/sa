## Glossary
```
Application
	Spark Application的概念和Hadoop MapReduce中的类似，指的是用户编写的Spark应用程序，包含了一个Driver 功能的代码和分布在集群中多个节点上运行的Executor代码；

Driver
	Spark中的Driver即运行上述Application的main()函数并且创建SparkContext，其中创建SparkContext的目的是为了准备Spark应用程序的运行环境。在Spark中由SparkContext负责和ClusterManager通信，进行资源的申请、任务的分配和监控等；当Executor部分运行完毕后，Driver负责将SparkContext关闭。通常用SparkContext代表Drive；

Executor
	Application运行在Worker 节点上的一个进程，该进程负责运行Task，并且负责将数据存在内存或者磁盘上，每个Application都有各自独立的一批Executor。在Spark on Yarn模式下，其进程名称为CoarseGrainedExecutorBackend，类似于Hadoop MapReduce中的YarnChild。一个CoarseGrainedExecutorBackend进程有且仅有一个executor对象，它负责将Task包装成taskRunner，并从线程池中抽取出一个空闲线程运行Task。每个CoarseGrainedExecutorBackend能并行运行Task的数量就取决于分配给它的CPU的个数了；

Cluster Manager
	指的是在集群上获取资源的外部服务，目前有：
		Standalone：Spark原生的资源管理，由Master负责资源的分配；
		Hadoop Yarn：由YARN中的ResourceManager负责资源的分配；
Worker
	集群中任何可以运行Application代码的节点，类似于YARN中的NodeManager节点。在Standalone模式中指的就是通过Slave文件配置的Worker节点，在Spark on Yarn模式中指的就是NodeManager节点；

Job
	包含多个Task组成的并行计算，往往由Spark Action催生，一个JOB包含多个RDD及作用于相应RDD上的各种Operation；

Stage
	每个Job会被拆分很多组Task，每组任务被称为Stage，也可称TaskSet，一个作业分为多个阶段；

Task
	被送到某个Executor上的工作任务；
	
Transformation
    
Action

RDD
    Resilient Distribute Dataset 弹性分布式数据集
    RDD可以由Java, Python, Scala对象构成
    RDD是分布式的对象集合, 但对象内部结构无法获取 
    优点
        编译时类型安全
        面向对象接口
        任何IO操作都需要对象全部序列化或反序列化

DataFrame
    off-heap: jvm堆内存之外的内存, 可以跳出jvm的限制
    schema: 每行数据都有相同的结构
    优缺点
        函数式编程
        执行效率高
        减少数据读取

DataSet
    优缺点
        DataSet可以在编译时检查类型
        面向对象的编程接口
    数据被Encoder以编码的二进制形式被存储，不需要反序列化就可以执行sorting、shuffle等操作, 执行效率更快


DStream
    Discretized Streams 
```


## 特点
```
内存运算, 支持交互式查询, 流式处理  
交互式分析
    spark-shell(scala)
    pyspark(python)

运行
    spark-context
    spark-submit <scala|java>
```


### Spark Library
```
Spark Core
 	核心: 内存运算和引用外部存储为RDD
Streaming	
	数据流被抽象成dstream 
SQL and DataFrame
	结构化的数据被抽象为DataFrame, 提供类SQL API进行操作
MLlib(machine learning)
	处理的数据是不规则的
Graphx(graph)
	图计算
```

## Hadoop集成
1. Standalone  只使用HDFS  
2. Hadoop Yarn 替代MapReduce  


## Hadoop, Spark性能对比
```
Hadoop
	1. 产生的中间数据必须保存在HDFS
	2. shuffler必须同步等待mapper执行完成
	3. reducer同步等待mapper完成才能执行  

Spark
	1. 中间数据保存在内存中
	2. 数据可以选择被持久化在内存中

```

## Topic
1. Broadcast variables allow the programmer to keep a read-only variable cached on each machine rather than shipping a copy of it with tasks. 

