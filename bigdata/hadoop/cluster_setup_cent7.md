## 1. Overview
```
version
	jdk: 1.8
	hadoop: 2.8.3
	
/etc/hosts
	192.168.122.30  hadoop1 (name node + data node)
	192.168.122.31  hadoop2 (data node)
	192.168.122.32  hadoop3 (data node)
```

## 2. 准备工作
```
install jdk-1.8.tar.gz  
install hadoop-2.8.2.tar.gz


every node
    export JAVA_HOME=/usr/local/jdk
    export HADOOP_HOME=/usr/local/hadoop
    export HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop
    export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true

    export PATH=${JAVA_HOME}/bin:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:$PATH

master node
    ssh-copy-id root@hadoop1
    ssh-copy-id root@hadoop2
    ssh-copy-id root@hadoop3
```
## 3. 配置HDFS与Yarn
### 3.1 配置HDFS
```
配置项 
	https://hadoop.apache.org/docs/r1.2.1/hdfs-default.html
获取配置
	hdfs getconf -confKey fs.defaultFS
```

#### 3.1.1 master node

#### 3.1.1.1 etc/hadoop/core-site.xml
```
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://hadoop1:9000</value>
    </property>
   <property>
      <name>dfs.permissions.enabled</name>
      <value>false</value>
   </property>
    <property>
        <name>hadoop.native.lib</name>
        <value>false</value>
    </property>
    <property>
      <name>hadoop.proxyuser.root.groups</name>
      <value>*</value>
    </property>
    <property>
      <name>hadoop.proxyuser.root.hosts</name>
      <value>*</value>
    </property>

</configuration>
```
#### 3.1.1.2. etc/hadoop/hdfs-site.xml
```
<configuration>
   <property>
       <name>dfs.webhdfs.enabled</name>
       <value>true</value>
   </property>

   <property>
      <name>dfs.data.dir</name>
      <value>/data/hadoop/dfs/datanode</value>
      <final>true</final>
   </property>

   <property>
      <name>dfs.name.dir</name>
      <value>/data/hadoop/dfs/namenode</value>
      <final>true</final>
   </property>

   <property>
      <name>dfs.replication</name>
      <value>1</value>
   </property>

</configuration>
```
#### 3.1.1.3 etc/hadoop/slaves
```
hadoop1 
hadoop2 
hadoop3 
```
#### 3.1.1.4 run command
```
hdfs namenode -format
```

### 3.1.2 data node
```
rsync -r /usr/local/hadoop/etc/hadoop  root@hadoop2:/usr/local/hadoop/etc/hadoop
rsync -r /usr/local/hadoop/etc/hadoop  root@hadoop3:/usr/local/hadoop/etc/hadoop
```
### 3.1.3 start-dfs
```
start-dfs.sh # default log dir ${HADOOP_HOME}/logs
web gui: http://ip:50070
```

### 3.1.4 ensure hdfs is working
```
hdfs dfs -mkdir /test
hdfs dfs -ls /
hdfs dfs -put  /root/archive/hadoop-2.8.2.tar.gz   /test
hdfs dfs -rmdir --ignore-fail-on-non-empty /test
```

 
## 3.2 配置YARN
### 3.2.1 master node
#### 3.2.1.1 etc/hadoop/mapred-site.xml
```
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
```
#### 3.2.1.2 etc/hadoop/yarn-site.xml
```
<configuration>

    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>

    <property>
		<!-- 防止卡在running job -->
        <name>yarn.resourcemanager.hostname</name>
        <value>hadoop1</value>
    </property>

    <property>
        <name>yarn.acl.enable</name>
        <value>false</value>
    </property>
    <property>
        <name>yarn.resourcemanager.address</name>
        <value>hadoop1:8032</value>
    </property>
    <property>
        <name>yarn.resourcemanager.scheduler.address</name>
        <value>hadoop1:8030</value>
    </property>
    <property>
        <name>yarn.resourcemanager.resource-tracker.address</name>
        <value>hadoop1:8031</value>
    </property>

</configuration>

```
### 3.2.2 data node

```
rsync -r /usr/local/hadoop/etc/hadoop  root@hadoop2:/usr/local/hadoop/etc/hadoop
rsync -r /usr/local/hadoop/etc/hadoop  root@hadoop3:/usr/local/hadoop/etc/hadoop
```
### 3.2.3 start map-reduce
```
master
	start-yarn.sh
```
### 3.2.4 ensure mapreduee working
```

hdfs dfs -mkdir /user
hdfs dfs -mkdir /user/root
hdfs dfs -put etc/hadoop/  input

# 路径必须正确
hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.8.3.jar grep input output 'dfs[a-z.]+'
hdfs -ls /user/root
hdfs dfs -ls  # 默认list /user/root/
hdfs dfs -cat output/*
```
## 3.2.4 启动job history server
```
master
	mr-jobhistory-daemon.sh  --config /usr/local/hadoop/etc start historyserver # 启动非常慢
	web-gui: hadoop1:19888
```
