## usage
```
hbase shell 进入交互式
status: output server status  
version: output server version  
whoami: output information of current user  
describe <table name>: describe table   
is_enabled <table> : check if table is enabled  
alter <table>: alter a table  
drop_all <regexp>: drop all tables matching 'regexp'  
table_help 获取表操作相关帮助
list 显示所有表

## create a table
create  'emp','personal','job'

## Drop a table
disable 'emp' # must be disabled before dropped
drop 'emp'
exists 'emp'

## Insert or Update data
put 'emp', '1', 'personal:name', 'Bob'
put 'emp', '1', 'personal:age', 34

put 'emp','1','job:title','CEO'
put 'emp','1','job:salary',1345   # 插入数据
put 'emp','1','job:salary',13450 # 更新数据


scan 'emp' # get all rows of table
count 'emp' # get rows of table

truncate 'emp' # clear all data

# get row by row_key
get 'emp', '1' 

COLUMN          CELL
    job:salary     timestamp=1478856940758, value=13450
    job:title      timestamp=1478856929626, value=CEO
    personal:age   timestamp=1478856884425, value=34
    personal:name  timestamp=1478856875511, value=Bob

# get a specific column 
get 'emp', '1', {COLUMN => 'personal:name'}
COLUMN                  CELL
    personal:name          timestamp=1478856875511, value=Bob

get 'emp','1',{COLUMN => ['job:salary', 'personal:name']}
COLUMN                  CELL
    job:salary             timestamp=1478862365295, value=124124
    personal:name          timestamp=1478862192934, value=Bob

 
delete '<table name>', '<row>', '<column name >', <time stamp> # ts should not be quoted
delete 'emp','1','job:salary' # 删除所有版本数据
delete 'emp','1','job:salary',1478859240219

deleteall '<table name', '<row>'
deleteall 'emp',1


```

## Scan 
```
STARTROW, ENDROW 使用row key过滤
LIMIT 返回记录行数
TIMERANGE 按照记录插入的时间过滤
COLUMNS 只查询特定的column


hbase> scan 'hbase:meta'
hbase> scan 'hbase:meta', {COLUMNS => 'info:regioninfo'}
hbase> scan 'ns1:t1', {COLUMNS => ['c1', 'c2'], LIMIT => 10, STARTROW => 'xyz'}
hbase> scan 't1', {COLUMNS => ['c1', 'c2'], LIMIT => 10, STARTROW => 'xyz'}
hbase> scan 't1', {COLUMNS => 'c1', TIMERANGE => [1303668804, 1303668904]}
hbase> scan 't1', {REVERSED => true}
hbase> scan 't1', {FILTER => "(PrefixFilter ('row2') AND
  (QualifierFilter (>=, 'binary:xyz'))) AND (TimestampsFilter ( 123, 456))"}
hbase> scan 't1', {FILTER =>
  org.apache.hadoop.hbase.filter.ColumnPaginationFilter.new(1, 0)}
hbase> scan 't1', {CONSISTENCY => 'TIMELINE'}
For setting the Operation Attributes 
hbase> scan 't1', { COLUMNS => ['c1', 'c2'], ATTRIBUTES => {'mykey' => 'myvalue'}}
hbase> scan 't1', { COLUMNS => ['c1', 'c2'], AUTHORIZATIONS => ['PRIVATE','SECRET']}

```
## 权限
```
# 权限用五个字母表示： "RWXCA".
# READ('R'), WRITE('W'), EXEC('X'), CREATE('C'), ADMIN('A')

grant 'test','RW','t1' ## 给test用户分配t1表的RW权限
user_permission 't1'  ## 查看权限
revoke 'test','t1' ## 收回权限

```

## Column Family
```
# 添加column family, 规定每个cell只能存储最近5个版本的历史数据
# 只新增cf可以不disable
alter 't1', {NAME => 'cf2', VERSIONS => 5, TTL='3600'}

# 删除 column family
alter 'table name', {NAME => 'cf1', METHOD => 'delete'}
# 修改CF TTL
alter 'table name', {NAME => 'cf1', TTL => '3600'}
```



## Region
```
# 迁移region
move 'encodeRegionName', 'ServerName'
# 开关自动平衡
balance_switch true|false
# 手动split
split 'regionName', 'splitKey'
#Compact all regions in a table:
hbase> major_compact 't1'
#Compact an entire region:
hbase> major_compact 'r1'
#Compact a single column family within a region:
hbase> major_compact 'r1', 'c1'
#Compact a single column family within a table:
hbase> major_compact 't1', 'c1'
```
