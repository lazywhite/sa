## Glossary
```
Application
	Spark Application的概念和Hadoop MapReduce中的类似，指的是用户编写的Spark应用程序，包含了一个Driver 功能的代码和分布在集群中多个节点上运行的Executor代码；
    一个application往往会生成多个job(action)

Driver
	Spark中的Driver即运行上述Application的main()函数并且创建SparkContext，其中创建SparkContext的目的是为了准备Spark应用程序的运行环境。在Spark中由SparkContext负责和ClusterManager通信，进行资源的申请、任务的分配和监控等；当Executor部分运行完毕后，Driver负责将SparkContext关闭。通常用SparkContext代表Driver;

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
    将dataset转换为另一个dataset
    
Action
    根据dataset返回计算结果

Parallelized Collections

RDD
    Resilient Distribute Dataset 弹性分布式数据集
    RDD可以由Java, Python, Scala对象构成
    RDD是分布式的对象集合, 但对象内部结构无法获取 
    优点
        编译时类型安全
        面向对象接口
        任何IO操作都需要对象全部序列化或反序列化
    特点
        resilient: fault tolerant
        distribute
        partitioned: breaks into chunks of data
        immutable: read only

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

cluster
    Master
        SparkContext(Driver program)
    standby master
        HA(zookeeper)
    resource manager
        Yarn
        spark
        mesos
        kubernate
    Slave
        executor
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


## MLlib
```
Classification
    DecisionTree
    RandomForest
    MultiLayer perceptron
    Linear Support Vector Machine
    Naive Bayes
Regression
    Linear
    Logisitc
    GBT

Clustering
    K-Means
    Bisecting K-Means
    LDA
    GMM

Feature
    extraction
        FeatureHasher
    selection
        VectorSlicer
        ChiSqSelector(按卡方测试筛选)
            numTopFeatures: 按固定数量挑选
            percentile: 按全部feature的百分比挑选
            fpr: 选取低于阈值的所有feature
            fdr
            fwe
        QuantileDiscretizer(多分离散器, 自动划分)
            numBuckets
        Binarizer(两分离散器)
            threshold
        Bucketizer(多分离散器, 需要手动指定区间)
            splits=[-float("inf"), -50, 0, 50, float("inf")]
    transformation
        VectorAssembler
        Tokenizer

```
## Streaming
```
structured 
unstructured

DStream: discreted stream

input table
output table
output mode
    complete
    append
    update
query
```

## Hive交互
```
关闭schema验证
hive/conf/hive-site.xml
    <property>
       <name>hive.metastore.schema.verification</name>
       <value>false</value>
    </property>

每个节点执行
    ln -s /usr/local/hadoop/etc/hadoop/core-site.xml  /usr/local/spark/conf/
    ln -s /usr/local/hadoop/etc/hadoop/hdfs-site.xml  /usr/local/spark/conf/
在master节点执行
    ln -s /usr/local/hive/conf/hive-site.xml  /usr/local/spark/conf/

spark-sql --master spark://<ip>:<port> -S 
    如果正确配置, 不会在当前目录生成metastore_db, spark-warehouse文件夹

client mode
    df = spark.sql("select * from <hivedb>.<table>") # 从hive table加载数据
    df.write.mode("overwrite").saveAsTable("db.result") # 写入hive table, 默认为parquet格式
cluster mode
    spark = SparkSession.builder.appName("main").enableHiveSupport().getOrCreate()

pyspark和spark-sql无法同时操作同一张表, beeline和spark-sql可以

```
## Spark on Yarn
```
前提:
    spark runtime的二进制jar包, spark.yarn.jars 默认为SPARK_HOME/jars, 会被上传给yarn
    具备HADOOP_CONF_DIR环境变量
    yarn-site.xml 添加相关配置, 重启yarn
    使用时spark-cluster可以开启, 也可以是关闭状态

运行模式
    spark-submit --master yarn --deploy-mode [cluster, client]

    每个application都有一个driver, 
        如果是client模式, 则driver运行在提交任务的机器
            deploy-mode是client时, 为了防止找不到driver, 需要加参数 --conf spark.driver.host=<client ip>
        如果是cluster模式, driver运行在任意一台worker节点


避免每次上传spark jar包
    cd $SPARK_HOME/jars
    zip -r spark-2.1.1-jars.zip *.jar
    hdfs dfs -put spark-2.1.1-jars.zip /tmp
    spark-submit --conf spark.yarn.archive=hdfs:///tmp/spark-2.1.1-jars.zip

上传python解释器, 避免python版本问题
    zip -r anaconda3.zip /anaconda3
    hdfs dfs -put anaconda3.zip /tmp
    spark-submit --archives hdfs:///tmp/anaconda3.zip#anaconda3 
                 --conf spark.yarn.appMasterEnv.PYSPARK_PYTHON=./anaconda3/anaconda3/bin/python3
```
## Tips
```
1. Shared Variable
    Broadcast variable: 全局只读共享变量
        val bv = sc.broadcast(Array(1, 2, 3))
        bv.value
        每个executor可以缓存一个变量, 不需要为每个task进行copy
    Accumulator: 只能增加的变量, 用来做计数器或sum
        val accum = sc.longAccumulator(10) # 注册无名称的累加器
        val accum = sc.accumulator[Long](100, "accum1") # 有名称的累加器会显示在相关stage的webUI上
        sc.parallelize(Array(1, 2, 3, 4)).foreach(x => accum.add(x))
        accum.value

2. sqlDF.show()
    UnicodeEncodeError: 'ascii' codec can't encode characters in position 641-645: ordinal not in range(128)
    export PYTHONIOENCODING=utf8


3. 增加自定义column
    from pyspark.sql.types import *
    from pyspark.sql.functions import udf

    get_pool_id = udf(
        lambda val: '-'.join(val.split('-')[:4]),
        StringType()
    )

    df_with_pool_id_DF = pserverDF.withColumn('pool_id', get_pool_id(pserverDF.resource_id))

csv文件操作
    df = spark.read.option("header", True).csv('file.csv')
    spark.write.option('header', True).save('file', format='csv')
    dataframe保存的结果是分成了很多part, 是计算的分布式导致的, 需要人工merge为单一文件

spark.sql(sql) 
    sql 不支持from之前有包含where的子查询
    sql 不支持中文column name

dataframe join duplicate column
    df1.join(df2, ['col1', 'col2'], 'inner') # 可以避免同名join字段, 无法避免非join同名字段

更改column dtype
    df = df.withColumn('data', df.data.cast('double'))

spark-sql insert不能指定字段, 必须插入全列, 空值传Null

CLI工具
    pyspark: python环境交互式
    spark-shell: scala环境交互式
    sparkR: R环境交互式
    spark-sql: 操作hive table, 不使用hadoop mapreduce

spark执行资源设置
    too many open files
        ulimit -n 65535
    内存设置
        spark-submit --executor-memory 60G --driver-memory 60G run.py


pyspark 使用ipython
    export PYSPARK_DRIVER_PYTHON=ipython


RDD可以自动从node failure恢复
使用本地文件系统作为data source, 必须保证所有worker也可在同样位置访问
spark.read.textFile()支持文件夹, 通配符, 压缩文件
所有的transformation都是lazy的, 直到有action发生

可以直接在文件上执行sql
SaveMode
    default: 存在即报错
    append: 添加
    overwrite: 覆盖
    ignore: 存在不做任何操作

pivot的字段, 值一定不能为null

pyspark shell使用mysql表数据

    pyspark --packages mysql:mysql-connector-java:5.1.38 # 使用maven坐标
    spark-shell --driver-class-path postgresql-9.4.1207.jar --jars postgresql-9.4.1207.jar #手动指定驱动包
    spark使用ivy包管理工具

    df = spark.read.format("jdbc").options(
        url ="jdbc:mysql://localhost/test",
        driver="com.mysql.jdbc.Driver",
        dbtable="bb",
        user="root",
        password="").load()

spark使用mysql数据
    spark/jars
        mysql-connector-java-5.1.38-bin.jar

spark.sql(sql) 执行的sql如果包含中文, 需要使用``

只有发生shuffle, sort才会导致stage变化

action会触发job

添加hadoop支持后, 加载本地文件
    spark.read.textFile("file:///root/file")
    sc.read.textFile("file:///root/file") # 使用sc, 路径必须在每个node都存在

    spark.read.textFile("file") # 默认加载hdfs://ip:<port>/user/<username>/file

c.select(c("mobile"), (c("data") * 2).alias("hehe")).show()
c.selectExpr("mobile", "2 * data").show()

df.na: 针对not available数据的算子
    df.na.drop()
    df.na.fill()
    df.na.replace()

udf
    def get_slope():
        pass
    spark.udf.register("get_slope", get_slope, FloatType())


    get_slope = udf(lambda val: func(val), FloatType())
    df.select("name", get_slope("col"))


df = spark.createDataFrame([(1, 10), (2, 20)], ("features", "label"))
part1, part2 = df.randomSplit([0.3, 0.7]) # 按照权重分割

字段重命名
    pyspark.sql.functions.col
    df.select(col("old").alias("new"), "col2")

    df.selectExpr("old as new", "col2")

import pyspark.sql.functions as f
    df2 = df.select(f.explode(f.split(df.value, " ").alias("words")))

df.show(truncate=False)

运行模式
    single node
    cluster
        stand-alone
        spark on yarn
            HADOOP_CONF_DIR
            spark-submit --master yarn

Kafka
     pyspark --packages org.apache.spark:spark-sql-kafka-0-10_2.11:2.3.0


    Source
        # for stream query
        df = spark.readStream.format("kafka").option("kafka.bootstrap.servers", "kafka1:9092,kafka2:9092,kafka3:9092").option("subscribe", "test").load()

        # for batch query
        df = spark.read.format("kafka").option("kafka.bootstrap.servers", "kafka1:9092,kafka2:9092,kafka3:9092").option("subscribe", "test").load()

        # 订阅多个topic
        .option("subscribe", "topic1,topic2") \

        # 按pattern订阅
        option("subscribePattern", "topic.*")

        df.selectExpr("CAST(key AS STRING)", "CAST(value AS STRING)").show()
    Sink
        ds = df.selectExpr("CAST(key AS STRING)", "CAST(value AS STRING)").writeStream.format("kafka").option("kafka.bootstrap.servers", "host1:port1,host2:port2").option("topic", "topic1").start() 


spark streaming writeStream无法直接写入hive表, 先写入HDFS, 然后用hive external table分析
spark streaming无法在集群模式运行, 只能单机运行
writeStream().option("path", "/path/to/output") 后续无法继续append的问题

设置kafka读取速率, 防止内存爆炸和HDFS写入
spark-sql无法实现client查询, beeline可以

df.foreach(lambda row: f(row)) 无法访问外部变量, 更改为
    data = df.collect() 
    for row in data:
        do()
  

hive load parquet 

org.codehaus.janino.JaninoRuntimeException: Code of method "processNext()V" of 
class "org.apache.spark.sql.catalyst.expressions.GeneratedClass$GeneratedIterator" 
grows beyond 64 KB
    sparkSession.builder.config("spark.sql.codegen.wholeStage", False)

spark history server
    1. conf/spark-defaults.conf
        spark.history.fs.logDirectory      hdfs://hadoop1:9000/log/spark-events
        spark.history.ui.port              18080
    2. sbin/start-history-server.sh        http://<ip>:18080, 支持api调用
    3. app configuration
        1. 运行时指定
            spark = SparkSession.builder.config("spark.eventLog.enabled", True).config("spark.eventLog.dir", "hdfs://hadoop1:9000/log/spark-events")
        2. 持久化
            conf/spark-defaults.conf
                spark.eventLog.enabled           true
                spark.eventLog.dir               hdfs://redhat166:9000/log/spark-events



spark 日志配置
    conf/log4j.properties, 同步至所有节点

        log4j.rootCategory=INFO, console, FILE  # 总体级别
        log4j.appender.console=org.apache.log4j.ConsoleAppender
        log4j.appender.console.target=System.err
        log4j.appender.console.layout=org.apache.log4j.PatternLayout
        log4j.appender.console.layout.ConversionPattern=%d{yy/MM/dd HH:mm:ss} %p %c{1}: %m%n

        log4j.logger.org.apache.spark.repl.Main=WARN

        log4j.logger.org.spark_project.jetty=WARN
        log4j.logger.org.spark_project.jetty.util.component.AbstractLifeCycle=ERROR
        log4j.logger.org.apache.spark.repl.SparkIMain$exprTyper=INFO
        log4j.logger.org.apache.spark.repl.SparkILoop$SparkILoopInterpreter=INFO
        log4j.logger.org.apache.parquet=ERROR
        log4j.logger.parquet=ERROR

        log4j.logger.org.apache.hadoop.hive.metastore.RetryingHMSHandler=FATAL
        log4j.logger.org.apache.hadoop.hive.ql.exec.FunctionRegistry=ERROR

        log4j.appender.FILE=org.apache.log4j.DailyRollingFileAppender
        log4j.appender.FILE.Threshold=DEBUG  # 级别阈值
        log4j.appender.FILE.file=/var/log/spark.log
        log4j.appender.FILE.DatePattern='.'yyyy-MM-dd
        log4j.appender.FILE.layout=org.apache.log4j.PatternLayout
        log4j.appender.FILE.layout.ConversionPattern=[%-5p] [%d{yyyy-MM-dd HH:mm:ss}] [%C{1}:%M:%L] %m%n

pyspark 获取spark logger
    Logger = spark._jvm.org.apache.log4j.Logger
    Level = spark._jvm.org.apache.log4j.Level
    mylogger = Logger.getLogger(__name__)
    mylogger.setLevel(Level.WARN)
    mylogger.error("some error trace")
    mylogger.info("some info trace")

spark session config
    pyspark.conf.SparkConf
    conf = SparkConf()
    conf.set("spark.sql.codegen.wholeStage", False)
    spark = SparkSession.builder.config(conf=conf).getOrCreate()

重命名字段
    a.select(col("_c0").alias("user_id"))
    a.toDF("user_id", "name")

pyspark 报java.lang.IllegalArgumentException: Error while instantiating 'org.apache.spark.sql.hive.HiveSessionState':

    HADOOP_CONF_DIR环境变量要么注释掉, 要么确保hive正常运行

spark mongodb
    注意驱动和spark版本适配
    mongodb >=3.2

    spark = SparkSession \
        .builder \
        .appName("myApp") \
        .config("spark.mongodb.input.uri", "mongodb://127.0.0.1/test.coll") \
        .config("spark.mongodb.output.uri", "mongodb://127.0.0.1/test.coll") \
        .getOrCreate()

    pyspark --conf "spark.mongodb.input.uri=mongodb://127.0.0.1/test.myCollection?readPreference=primaryPreferred" \
                  --conf "spark.mongodb.output.uri=mongodb://127.0.0.1/test.myCollection" \
                  --packages org.mongodb.spark:mongo-spark-connector_2.11:2.2.2

    people = spark.createDataFrame([("Bilbo Baggins",  50), ("Gandalf", 1000), ("Thorin", 195), ("Balin", 178), ("Kili", 77),
       ("Dwalin", 169), ("Oin", 167), ("Gloin", 158), ("Fili", 82), ("Bombur", None)], ["name", "age"])

    # 写数据
    people.write.format("com.mongodb.spark.sql.DefaultSource").mode("append").save()
    # 改变默认output collection
    people.write.format("com.mongodb.spark.sql.DefaultSource").mode("append").option("database",
    "people").option("collection", "contacts").save()

    # 读数据
    df = spark.read.format("com.mongodb.spark.sql.DefaultSource").load()
    df = spark.read.format("com.mongodb.spark.sql.DefaultSource").option("uri", "mongodb://127.0.0.1/people.contacts").load()

spark性能高原因
    使用DAG算法, 避免生成HDFS的中间文件


spark application调度
    stand-alone
        只能是FIFO, 每个app尝试使用全部节点, 可以通过--conf spark.cores.max 控制使用的节点数, --conf spark.executor.memory 控制使用的内存
    yarn
        resource manager有多种调度器 Capacity, FIFO, Fair, 配合queue使用
        --num-executors  # 控制使用的worker个数(一般一个worker产生一个executor)
        --executor-memory # 控制单个executor使用的内存
        --executor-cores  # 控制单个executor使用的内核


spark动态资源分配
    spark application可以使用此特性, 默认是禁止的
    开启方法
        1. application提交必须添加此参数
            --conf spark.dynamicAllocation.enabled=true
        2. 开启external shuffle service
            standalone mode
                 配置spark.shuffle.service.enabled=true, 并重启所有worker
            mesos
                配置spark.shuffle.service.enabled=true
                所有worker执行sbin/start-mesos-shuffle-service.sh 
            yarn
                http://spark.apache.org/docs/latest/running-on-yarn.html#configuring-the-external-shuffle-service

spark application内部job调度                
    http://spark.apache.org/docs/latest/job-scheduling.html#scheduling-within-an-application
            --conf spark.shuffle.service.enabled=true 

    http://spark.apache.org/docs/latest/running-on-yarn.html#configuring-the-external-shuffle-service

测试任务提交
spark-submit --master yarn  --num-executors 20 --executor-memory 5g  --class org.apache.spark.examples.JavaSparkPi /opt/spark-2.1.1/examples/jars/spark-examples_2.11-2.1.1.jar


spark 看不到hive database
    ln -s /path/to/hive-site.xml /path/to/spark/conf/
    spark-env.sh
        SPARK_CONF_DIR=/path/to/spark/conf

parquet to csv
    DataFrame df = sqlContext.parquetFile("parquet path");  
    df.javaRDD().saveAsTextFile("outputpath");
```

