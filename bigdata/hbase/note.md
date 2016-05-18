## Concept
HBASE is the hadoop database, a distribute, scalable, big data store  
Use hbase when you need random, realtime read/write access to your BigData  
Hbase is distributed, versioned, non-relational database 

HBase is a data model that is similar to Google’s big table designed to provide quick random access to huge amounts of structured data.
## Features
strictly consistent reads and writes  
automatic and configurable sharding of tables  
automatic failover support between RegionServers  
Convenient base classes for backing MapReduce jobs with Hbase Tables  
Block cache and Bloom Filters for real-time queries  
query predicate push down via server-side filters  
thrift gateway and a rest-full web service that support XML, Protobuf and Binary data encoding options  
Jruby-based(JIRB) shell  
Support for exporting metrics via Hadoop metrics subsystem to files or Ganglia  


## Installation
```
#brew install hbase
#export HBASE_HOME="/usr/local/Cellar/hbase/1.1.2/libexec"
##conf/hbase-site.xml
<configuration>
    <property>
        <name>hbase.rootdir</name>
        <value>hdfs://localhost:9000/hbase</value>
    </property>

   <property>
      <name>hbase.zookeeper.property.clientPort</name>
      <value>2181</value>
      <description>Property from ZooKeeper's config zoo.cfg.
      The port at which the clients will connect.
      </description>
    </property>
    <property>
      <name>hbase.zookeeper.quorum</name>
      <value></value>
      <description>Comma separated list of servers in the ZooKeeper Quorum.
      For example, "host1.mydomain.com,host2.mydomain.com,host3.mydomain.com".
      By default this is set to localhost for local and pseudo-distributed modes
      of operation. For a fully-distributed setup, this should be set to a full
      list of ZooKeeper quorum servers. If HBASE_MANAGES_ZK is set in hbase-env.sh
      this is the list of servers which we will start/stop ZooKeeper on.
      </description>
    </property>
    <property>
      <name>hbase.zookeeper.property.dataDir</name>
      <value>/usr/local/zookeeper</value>
      <description>Property from ZooKeeper's config zoo.cfg.
      The directory where the snapshot is stored.
      </description>
    </property>
</configuration>u
## hbase-env.sh
export JAVA_HOME="$(/usr/libexec/java_home)"
export HBASE_MANAGES_ZK=true

mkdir /usr/local/zookeeper
# start hbase service 
start-hbase.sh
or 
hbase shell
```

## Problems 
integrate with zookeeper

