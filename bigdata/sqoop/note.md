## Introduction
sqoop is designed to transfer data between Hadoop and RDBMS

## Configuration
```
#Set path to where bin/hadoop is available
export HADOOP_COMMON_HOME=/usr/local/hadoop/hadoop

#Set path to where hadoop-*-core.jar is available
export HADOOP_MAPRED_HOME=/usr/local/hadoop/hadoop

#set the path to where bin/hbase is available
export HBASE_HOME=/usr/local/hadoop/hbase

#Set the path to where bin/hive is available
export HIVE_HOME=/usr/local/hadoop/hive

```

## Usage
### 1. import data from RDBMS
```
sqoop import \
--connect jdbc:mysql://localhost/userdb \
--username root \
--table emp --m 1 \
--target-dir /queryresult \
--where 'city = "Bejing"' \
--incremental <mode> \ ## mode could be 'append'
--check-column <column name> \
-last value <value> \

```
### 2. import all tables
```
sqoop import-all-tables \
--connect jdbc:mysql://localhost/userdb \
--username root
```

### 3. export data to RDBMS
```
sqoop export \
--connect jdbc:mysql://localhost/db \
--username root \
--table employee \ 
--export-dir /emp/emp_data
```

### 4. sqoop job
"job" is saved 'import' or 'export' commands

```
sqoop job [--create|--list|--show|--exec|--delete]

```
### 5. sqoop eval
used to execute user-defined SQL queries
```
sqoop eval \
--connect jdbc:mysql://localhost/db \
--username root \ 
--query “SELECT * FROM employee LIMIT 3”
```
### 6. list-database
```
sqoop list-databases \
--connect jdbc:mysql://localhost/ \
--username root
```
### 7. list-tables
```
sqoop list-tables \
--connect jdbc:mysql://localhost/userdb \
--username root
```


### 8. interact with Hive 
```
sqoop import --connect jdbc:postgresql://127.0.0.1:54321/test_test_171_2 --username postgres --password password --table sale_order --hive-import --create-hive-table --direct

sqoop job --create syncSaleOrderJob -- import  --connect jdbc:postgresql://127.0.0.1:54321/test --username postgres --password password --table sale_order --incremental append --target-dir /user/hive/warehouse/sale_order --check-column id --m 1

sqoop job --exec syncSaleOrderJob
sqoop job --delete syncResPartner

```
