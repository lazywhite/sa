# 分布式集群安装
## 环境准备
```
1. jdk
2. scala
3. hadoop 
4. master节点到worker节点配置免密码登录  
```


## conf/spark-env.sh
```
export JAVA_HOME=/usr/jdk1.8.0_121
export SCALA_HOME=/usr/scala-2.12.1
export SPARK_MASTER_IP=10.10.0.1
export SPARK_WORKER_MEMORY=1g
export HADOOP_CONF_DIR=/usr/hadoop-2.7.3/etc/hadoop
```
## conf/slaves
```
DEV-SH-MAP-01
DEV-SH-MAP-02
DEV-SH-MAP-03
```

## 流程
1. 启动hadoop集群
2. 启动spark-master   #bin/start-master.sh
3. 启动所有spark-slave #bin/start-slave.sh
4. 状态查询http://10.10.0.1:8080
