## Tips
1. tables are horizonal split into 'regions' and are served by RegionServers  
2. 'Regions' are vertically divided by column families into 'Stores'  
3. 'Stores' are saved as files in HDFS    
4. 'Store'包含MemStore和HFiles
5. 'Memstore' 充当HFiles与接口之间的缓存层
6. 更新数据底层其实只是创建了cell的一个新版本数据



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
9. table_help 获取表操作相关帮助
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

```
row_key could be number or 'string'  


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


## 权限
```
# 权限用五个字母表示： "RWXCA".
# READ('R'), WRITE('W'), EXEC('X'), CREATE('C'), ADMIN('A')
grant 'test','RW','t1' ## 分配权限

user_permission 't1'  ## 查看权限
```

## Column Family
```
alter 't1', NAME => 'f1', VERSIONS => 5 ### 添加column family, 规定每个cell只能存储最近5个版本的历史数据
alter 'table name', 'delete' => 'column family'  ### 删除 column family
```

