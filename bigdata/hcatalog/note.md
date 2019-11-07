## Introduction
使用Hive的metastore和DDL操作数据, 并为其他工具(Pig, MapReduce)提供操作接口    

使用hcatalog操作hive，使用户无需关心数据存储在何处(hdfs, local)及存储的格式(csv,parquet)

HCatalog contains a data transfer API for parallel input and output without using MapReduce.
This API uses a basic storage abstraction of tables and rows to read data from Hadoop cluster and write data into it.
The Data Transfer API contains mainly three classes
    HCatReader − Reads data from a Hadoop cluster.
    HCatWriter − Writes data into a Hadoop cluster.
    DataTransferFactory − Generates reader and writer instances.

This API is suitable for master-slave node setup.

hcat只能执行DDL语句, 不支持DML语句  
