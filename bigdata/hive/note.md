## Keywords
```
derby
    metastore of hive
Hcatalog
    work on top of hive metastore, share metadata through applications
trift
    A rest api service for HiveServer2
  
table
partition
buckets
join
HiveServer
	
```
## Tips
```
hive运行于hadoop之上, 目的是处理结构化数据, 提升查询分析的性能. 
hive有类SQL接口, 每条语句会自动产生一个hadoop job执行, 实时性不高

Hive从0.14版本开始支持事务和行级更新，要想支持行级insert、update、delete，需要配置Hive支持事务。

数据最终存储在HDFS或HBase里面

```
## Hive组件
```
user interface
	CLI
	WebUI
	
HiveQL process engine
Execution Engine

```

## Hive事务配置
```
hive-site.xml 


<property>  
    <name>hive.support.concurrency</name>  
    <value>true</value>  
</property>  
<property>  
    <name>hive.exec.dynamic.partition.mode</name>  
    <value>nonstrict</value>  
</property>  
<property>  
    <name>hive.txn.manager</name>  
    <value>org.apache.hadoop.hive.ql.lockmgr.DbTxnManager</value>  
</property>  
<property>  
    <name>hive.compactor.initiator.on</name>  
    <value>true</value>  
</property>  
<property>  
    <name>hive.compactor.worker.threads</name>  
    <value>1</value>  
</property>  
```


## Partition
```
1. 创建一个分区表，以 ds 为分区列： 
	create table invites (id int, name string) partitioned by (ds string) row format delimited fields terminated by 't' stored as textfile; 
2. 将数据添加到时间为 2013-08-16 这个分区中： 
	load data local inpath '/home/hadoop/Desktop/data.txt' overwrite into table invites partition (ds='2013-08-16'); 
3. 将数据添加到时间为 2013-08-20 这个分区中： 
	load data local inpath '/home/hadoop/Desktop/data.txt' overwrite into table invites partition (ds='2013-08-20'); 
4. 从一个分区中查询数据： 
	select * from invites where ds ='2013-08-12'; 
5.  往一个分区表的某一个分区中添加数据： 
	insert overwrite table invites partition (ds='2013-08-12') select id,max(name) from test group by id; 
6. 可以查看分区的具体情况
	show partitions invites;
```

## Bucket
```
对于每一个表（table）或者分区， Hive可以进一步组织成桶，也就是说桶是更为细粒度的数据范围划分。划分依据是某一列的值.

create table bucketed_user(id int,name string) clustered by (id) sorted by(name) into 4 buckets row format delimited fields terminated by '\t' stored as textfile; 
```

## Join
```
inner join
   select * from aa a join bb b on a.c=b.a;
left join
	select * from aa a left outer join bb b on a.c=b.a;
right join
	select * from aa a right outer join bb b on a.c=b.a;
full join
	select * from aa a full outer join bb b on a.c=b.a;
left semi join
	select * from aa a left semi join bb b on a.c=b.a;
笛卡尔集
	 select * from aa join bb;
```