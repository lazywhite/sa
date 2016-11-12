## Introduction
## Keyword
```
Project
Datasource
    Tables
        Model
            Fact table
            Lookup table

            Dimension
                Measure
            Partition column
                Date value
            Filter
Cube
    Model
    Dimension
    Measure            
    Refresh
    Aggregation
    Permission    

HDFS
    cache file
Hbase 
    metadata
    final cube file

Hive
    dataSource


System 
    Server Config
    Server Environment
    Actions
        reload metadata
        disable cache
        set config
        calculate cardinality
Monitor
    Jobs
    Slow queries

Restful API
    
```
## Installation
1. tomcat installed , with CATALINA_HOME exported  
2. install kylin, export KYLIN_HOME   

## Configuration
```
conf/kylin.properties
    kylin.job.jar=/tmp/kylin/kylin-job-latest.jar
    kylin.coprocessor.local.jar=/tmp/kylin/kylin-coprocessor-latest.jar
bin/kylin.sh
    KYLIN_HOME
    HBASE_HOME
bin/setenv.sh
bin/find-hbase-dependency.sh   
bin/find-hive-dependency.sh
bin/find-kafka-dependency.sh
```
