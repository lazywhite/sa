# Introduction
influxdb is a time series database built for high write and query load  
influxdb is meant to be used as a backing store for any use case involving large amounts of timestamped data including DevOps monitoring, application metrics, IoT sensor data and real-time analytics;  

## Feature
1. high performance written specifically for time series data, the TSM engine  allows for high ingest speed and data compression   
2. simple high performing write and query HTTP(s) APIs    
3. Plugin support for other data ingestion protocols such as Graphit, collected and OpenTSDB  
4.  Expressive SQL-like query language 
5. Tags allow series to be indexed for fast and efficient queries   
6. Retention policies efficiency for fast and efficient data  
7. Continuous queries automatically compute aggregate data to make frequent queries more efficient  
8. Built-in web admin interface  
9. high available setup using Relay


## Keyword
```
TSM:  Time Structured Merge Tree
Database
    Measurement
        Timestamp
        Tag
        Field

Line Protoconl

RETENTION Policy

continuous query
cluster
    raft node
    data node
    
```

## Clustering
```
number of servers: 12
replication factor: 3
split: 4
shard duration: 7 day

Shards are distributed throughout an InfluxDB cluster. A shard holds the data for any number of time series for a contiguous block of time  
Shards are created for each new block of time.
 have a replication factor of 3 and a split of 4 and shard durations of 7 days. At the beginning of a new 7 day period we’d create 4 shards and make sure each shard exists on 3 different servers. So if we have a cluster of 12 machines, each one would get a shard.
```
### how to setup a cluster
1. set up a raft cluster  
2. join data node into raft cluster

## Networking
8083: admin panel
8086: http-api   /ping /query /write
8088,8091: internal communication port between instance of cluster


##using with grafana, collectd
### Building grafana from source
http://docs.grafana.org/project/building_from_source/


## Line protocol
1. The line protocol is a text based format for writing points to InfluxDB. Each line defines a single point. Multiple lines must be separated by the newline character \n.
2. tag is optional
3. never double or single quote "timestamp"
4. never single quote field value
5. never double or single quote measurement name, tag keys, tag values, and field keys 
6. do not double quote field values that are floats, integers, boolean, influxdb will assume that are string
7. double quote field values that are string
8. query by tag use where <tag key> = <tag value> , tag value should only be single quoted 

    commas ,
    equal signs = 
    spaces 



## Aggregate function
count()
    take a column name, and count the number of points that contains a non NULL value
min()
    return the lowest value from the specific column over a given interval, column must contain int64 or float64 values
max()
    return the highest value from the specific column over a given interval, column must contain int64 or float64 values
mean()
    returns the arithmetic mean (average) of the specified column over a given interval. The column must be of type int64 or float64.
mode()
    returns the most frequent value(s) of the specified column over a given interval 
median()
    returns the middle value from a sorted set of values for the specified column over a given interval
distinct()
    returns unique values for the given column.
percentile()
    returns the Nth percentile of a sorted set of values for the specified column over a given interval
histogram()
    requires at least one argument and at most two arguments. The first argument is the column name and the second argument is the bucket size
derivative()
    requires exactly one argument, which is a column name. The out is a column containing the value of (v_last - v_first) / (t_last - t_first) where v_last is the last value of the given column and t_last is the corresponding timestamp (and similarly for v_first and t_first)
sum()
    
stddev()
    requires exactly one argument, which is a column name. It outputs the standard deviation of the given column.
first/last()
    
difference()
    requires one argument, which is a column name. It will output the difference in the first and last value for each group by interval.
top/bottom()
   require two arguments, the column name and the number of top results to return.  



