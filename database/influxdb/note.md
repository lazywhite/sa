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

## Keyword
```
TSM:  Time Structured Merge Tree
Database
Measurement
Tag
Field
Line Protocol
    The line protocol is a text based format for writing points to InfluxDB. Each line defines a single point. Multiple lines must be separated by the newline character \n. The format of the line consists of three parts:  [key] [fields] [timestamp]


RETENTION Policy
```

## Networking
8083: admin panel
8086: client and server http-api
8088,8091: clusterd db-instance


##using with grafana, collectd
### Building grafana from source
http://docs.grafana.org/project/building_from_source/
