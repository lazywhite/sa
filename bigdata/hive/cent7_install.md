## Overview
version: 2.3.2  
仅需要在一个节点安装hive即可, 前提需要安装hadoop  

## Installation

```
tar xf hive.tar.gc -C /usr/local

确保以下环境变量 
    JAVA_HOME
    HADOOP_HOME
    HIVE_HOME

安装postgresql驱动
    yum -y install postgresql-jdbc
    ln -s /usr/share/java/postgresql-jdbc.jar  /usr/local/hive/lib/postgresql-jdbc.jar

安装配置postgresql server
    创建metastore database, hive:hive 用户
    
hdfs配置
    $ hdfs dfs -mkdir -p /user/hive/warehouse
    $ hdfs dfs -chmod g+w /tmp
    $ hdfs dfs -chmod g+w /user/hive/warehouse
```
## 配置

```
详见hive-site.xml

cp conf/hive-default.xml.template conf/hive-site.xml
cp conf/hive-log4j.properties.template conf/hive-log4j.properties

mkdir /usr/local/hive/tmp

conf/hive-site.xml
    设置tmpdir
        <name>system:java.io.tmpdir</name>
    注意以下配置, 并保证全局唯一
        <name>javax.jdo.option.ConnectionURL</name>
        <name>javax.jdo.option.ConnectionDriverName</name>
        <name>javax.jdo.option.ConnectionUserName</name>
        <name>javax.jdo.option.ConnectionPassword</name>
    
    针对postgresql的配置
		<property>
			<name>datanucleus.autoCreateSchema</name>
			<value>false</value>
		</property>

```

## 运行
```
## 初始化remote metastore表结构
# schematool -servers localhost -userName hive -passWord hive -dbType postgres -initSchema

## 启动metastore server
# hive --config /usr/local/hive/conf --service metastore >/path/to/hive-metastore.log 2>&1
# hive
hive>show tables;
```

## HiverServer2
```
1. 确保metastore service运行
2. conf/hive-site.xml
	  <property>
		<name>hive.server2.thrift.bind.host</name>
		<value>0.0.0.0</value>
		<description>Bind host on which to run the HiveServer2 Thrift service.</description>
	  </property>
	  <property>
		<name>hive.server2.thrift.bind.port</name>
		<value>10000</value>
		<description>Bind port</description>
	  </property>

	  <property>
		<name>hive.server2.thrift.client.user</name>
		<value>anonymouse</value>
		<description>Username to use against thrift client</description>
	  </property>
	  <property>
		<name>hive.server2.thrift.client.password</name>
		<value>anonymouse</value>
		<description>Password to use against thrift client</description>
	  </property>


3. 配置hdfs
   <property>
      <name>dfs.permissions.enabled</name>
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

4. 重启hdfs
	stop-dfs.sh
	start-dfs.sh
5. 运行hiveserver2 &
6. beeline -u jdbc:hive2://localhost:10000 -n root
```
