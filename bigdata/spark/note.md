## Keyword
```
节点类型
    Master
    Standby-master
    Slave

交互式分析
    spark-shell
    pyspark

运行
    spark-session
    spark-context
    spark-submit <scala|java>
    spark-class
    python script

```
## Installation
[Install Guild](http://zhongyaonan.com/hadoop-tutorial/setting-up-hadoop-2-6-on-mac-osx-yosemite.html)
  
## Concept
Apache Spark is a lightning-fast cluster computing designed for fast computation. It was built on top of Hadoop MapReduce and it extends the MapReduce model to efficiently use more types of computations which includes Interactive Queries and Stream Processing
 Spark not only supports ‘Map’ and ‘reduce’. It also supports SQL queries, Streaming data, Machine learning (ML), and Graph algorithms.

The main feature of Spark is its in-memory cluster computing that increases the processing speed of an application.

# Keyword
## RDD
Resilient Distribute Dataset, is an immutable distribute collection of objects;  
each dataset in RDD is divided into logical partitions, which may be computed   
on different nodes of the cluster, RDDS can contain any type of Python, Java,  
Scala objects, including user-defined classes.


### Charactor
1. read-only
2. partitioned
3. fault-tolerant

### create a RDD
1. parallelizing an existing collection
2. referencing a dataset in an external storage system (HDFS, HBASE...)


## DAG
directed acyclic graph
## Transformation
## Action

## Dstream
the basic abstraction in Spark Streaming.

# Components of Spark
## Spark Core
Spark Core is the underlying general execution engine for spark platform that all other functionality is built upon. It provides In-Memory computing and referencing datasets in external storage systems.
##  Streaming	
Spark Streaming leverages Spark Core's fast scheduling capability to perform streaming analytics. It ingests data in mini-batches and performs RDD (Resilient Distributed Datasets) transformations on those mini-batches of data.

## Spark SQL
spark SQL is a component on top of Spark Core that introduces a new data abstraction called SchemaRDD, which provides support for structured and semi-structured data.
## MLlib
MLlib is a distributed machine learning framework above Spark because of the distributed memory-based Spark architecture
## Graphx
GraphX is a distributed graph-processing framework on top of Spark. It provides an API for expressing graph computation that can model the user-defined graphs by using Pregel abstraction API. It also provides an optimized runtime for this abstraction.

## Integration with Hadoop
Standalone − Spark Standalone deployment means Spark occupies the place on top of HDFS(Hadoop Distributed File System) and space is allocated for HDFS, explicitly. Here, Spark and MapReduce will run side by side to cover all spark jobs on cluster.

Hadoop Yarn − Hadoop Yarn deployment means, simply, spark runs on Yarn without any pre-installation or root access required. It helps to integrate Spark into Hadoop ecosystem or Hadoop stack. It allows other components to run on top of stack.

Spark in MapReduce (SIMR) − Spark in MapReduce is used to launch spark job in addition to standalone deployment. With SIMR, user can start Spark and uses its shell without any administrative access.


### why Hadoop is slow
1.MapReduce has to save shared data into HDFS between iterations:Disk IO 
2. reducer must wait for mapper : Syncholization
3. mapper and shuffler serialize data: Serialization 
###  Why spark is fast
1. store intermediate results in a distributed memory instead of HDFS
2. If different queries are run on the same set of data repeatedly, this particular data can be kept in memory for better execution times


#### Programming
1. spark shell
2. application


#### other
You can mark an RDD to be persisted using the persist() or cache() methods on it. The first time it is computed in an action, it will be kept in memory on the nodes
