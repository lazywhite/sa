## 环境准备
```
1. jdk
2. scala
4. master节点到worker节点配置免密码登录  
5. 各节点配置环境变量
	export JAVA_HOME=/usr/jdk1.8.0_121
	export SCALA_HOME=/usr/scala-2.12.1
	export HADOOP_CONF_DIR=/usr/hadoop-2.7.3/etc/hadoop

注意
    最好跟hdfs部署在相同节点
    hdfs最好使用裸盘, 使用-noatime进行挂载, spark.local.dir配置多个挂载点
    最大内存占用设置为总内存75%
```

## 配置
```
各节点创建data dir

配置项文档
    https://spark.apache.org/docs/2.1.1/spark-standalone.html

## 每个节点 conf/spark-env.sh
	#!/usr/bin/env bash
	SPARK_MASTER_HOST=hadoop1
	SPARK_MASTER_PORT=7077
	SPARK_MASTER_WEBUI_PORT=8080
	SPARK_LOCAL_DIRS=/data/spark1,/data/spark2

## master 节点conf/slaves
	hadoop1
	hadoop2
	hadoop3
```

## 流程
```
1. 启动spark-master   master>bin/start-master.sh
2. 启动所有spark-slave master>/start-slaves.sh
3. web gui http://SPARK_MASTER_IP:8080
```
