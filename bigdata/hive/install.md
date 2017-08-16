## Installation

```
brew install hive

cp conf/hive-default.xml.template conf/hive-site.xml
cp hive-log4j.properties.template hive-log4j.properties

export HADOOP_HOME=/usr/local/Cellar/hadoop/hadoop.version.no
export HIVE_HOME=/usr/local/Cellar/hive/hive.version.no/libexec
export JAVA_HOME=$(/usr/libexec/java_home)

curl -L 'http://www.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.22.tar.gz/from/http://mysql.he.net/' | tar xz
cp mysql-connector-java-5.1.15/mysql-connector-java-5.1.22-bin.jar /usr/local/Cellar/hive/hive.version.no/libexec/lib/

mysql> CREATE DATABASE metastore;
mysql> Grant ALL on metastore.* to 'hiveuser'@'%' identified by 'password';

<property>
  <name>javax.jdo.option.ConnectionURL</name>
  <value>jdbc:mysql://localhost/metastore</value>
</property>
<property>
  <name>javax.jdo.option.ConnectionDriverName</name>
  <value>com.mysql.jdbc.Driver</value>
</property>
<property>
  <name>javax.jdo.option.ConnectionUserName</name>
  <value>hiveuser</value>
</property>
<property>
  <name>javax.jdo.option.ConnectionPassword</name>
  <value>password</value>
</property>
<property>
  <name>datanucleus.fixedDatastore</name>
  <value>false</value>
</property>


## 如果使用本地metastore, 才需要如下配置, 使用mysql无需配置 
hive-site.xml
$ hdfs dfs -mkdir -p /user/hive/warehouse
$ hdfs dfs -chmod g+w /tmp
$ hdfs dfs -chmod g+w /user/hive/warehouse

mkdir /tmp/hive_tmp_io
#change all ${system:java.io.tmpdir} to /tmp/hive_tmp_io


>hive 
```

