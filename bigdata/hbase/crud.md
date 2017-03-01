## Concept and Keyword
1. tables are horizonal split into 'regions' and are served by RegionServers  
2. 'Regions' are vertically divided by column families into 'Stores'  
3. 'Stores' are saved as files in HDFS    
4. 'Stores' contain 'MemStore' and 'Hfiles'  
  
```
HMaster: 
    assign regions to regionServer
    zookeeper to make HA
RegionServer
```
## start stop hbase 
```
start-hbase.sh
stop-hbase.sh
```

## Hbase shell
```
1. hbase shell: enter interactive shell mode  
2. status: output server status  
3. version: output server version  
4. whoami: output information of current user  
5. describe <table name>: describe table   
6. is_enabled <table> : check if table is enabled  
7. alter <table>: alter a table  
8. drop_all <regexp>: drop all tables matching 'regexp'  
```  

## Create a table
```
create  'emp','personal','job'
```
## Drop a table
```
disable 'emp' # must be disabled before dropped
drop 'emp'
exists 'emp'
```

## Insert or Update data
row_key could be number or 'string'  

```
put 'emp', '1', 'personal:name', 'Bob'
put 'emp', '1', 'personal:age', 34

put 'emp','1','job:title','CEO'
put 'emp','1','job:salary',13450

```
## Read data
```
1. scan 'emp' # get all rows of table

2. count 'emp' # get rows of table

3. truncate 'emp' # clear all data

3. get 'emp', '1'  # get row by row_key
COLUMN          CELL
 job:salary     timestamp=1478856940758, value=13450
 job:title      timestamp=1478856929626, value=CEO
 personal:age   timestamp=1478856884425, value=34
 personal:name  timestamp=1478856875511, value=Bob
 
4. get 'emp', '1', {COLUMN => 'personal:name'} # get a specific column 
COLUMN                  CELL
 personal:name          timestamp=1478856875511, value=Bob

5. get 'emp','1',{COLUMN => ['job:salary', 'personal:name']}
COLUMN                  CELL
  job:salary             timestamp=1478862365295, value=124124
  personal:name          timestamp=1478862192934, value=Bob

 
```

## Delete data
```
delete '<table name>', '<row>', '<column name >', <time stamp> # ts should not be quoted
delete 'emp','1','job:salary',1478859240219

deleteall '<table name', '<row>'
deleteall 'emp',1
```


## Topic
sql phrase end with "newline" not semi-colon  

### 1. Change the maxium number of cells of a column family, default is 1
```
alter 't1', NAME => 'f1', VERSIONS => 5
```
### 2. Delete a column family
```
alter 'table name', 'delete' ⇒ 'column family'
```
