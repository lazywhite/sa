## CLI
```
    connect <host:port>   connects to another node specified by host:port
    auth                  prompts for username and password
    pretty                toggles pretty print for the json format
    use <db_name>         sets current database
    format <format>       specifies the format of the server responses: json, csv, or column
    precision <format>    specifies the format of the timestamp: rfc3339, h, m, s, ms, u or ns
    consistency <level>   sets write consistency level: any, one, quorum, or all
    history               displays command history
    settings              outputs the current settings for the shell
    exit/quit/ctrl+d      quits the influx shell

    show databases        show database names
    show series           show series information
    show measurements     show measurement information
    show tag keys         show tag key information
    show field keys       show field key information
```
## User management
```
create user <username>

grant all privileges to <username>
revoke all privileges from <username>

show users

create user <username> with password '<password>'
CREATE USER "username" WITH PASSWORD 'password' WITH ALL PRIVILEGES


grant <all,read,write> on <dbname> to <username>
grant all on <dbname> to <username>

show grant from <username>
set password for <username> = '<password>'

drop user <username>

```

## Database
```
create database [if not exists ] <dbame>
show databases
drop database <dbname> 

```
## Retention policy
data duration and repica factor  

```
SHOW RETENTION POLICIES ON <dbname>;
CREATE RETENTION POLICY <retention_policy_name> ON <database_name> DURATION <duration> REPLICATION <n> [DEFAULT]
ALTER RETENTION POLICY <retention_policy_name> ON <database_name> DURATION <duration> REPLICATION <n> [DEFAULT]
DROP RETENTION POLICY <retention_policy_name> ON <database_name>

duration: determine how long influxdb keep the data, minimun retention period is 1 hour
    unit: m<minute> h<hour> d<day> w<weeks> INF<infinite>
    
replication: determine how many independent copies of each point are stored in cluster where n is the number of data nodes;

DEFAULT: sets the new retention policy as the default retention policy for the database.

 //创建新的Retention Policies
CREATE RETENTION POLICY "rp_name" ON "db_name" DURATION 30d REPLICATION 1 DEFAULT 
    rp_name：策略名
    db_name：具体的数据库名
    30d：保存30天，30天之前的数据将被删除
    它具有各种时间参数，比如：h（小时），w（星期）
    REPLICATION 1：副本个数，这里填1就可以了
    DEFAULT 设为默认的策略

```


## Measurements  
The measurement acts as a container for tags, fields, and the time column  

```
show measurements [where <tag key>=<tag value>];
drop measurement <mname>
```

## Series
a series is the collection of data that share a retention policy, measurement, and tag set  

```
show series [ from <measurement> ];
drop series <sname>
```

## Tag related
```
show tag keys from cpu;
name: cpu
---------
tagKey
cpu
host
```
```
show tag values from cpu with key = "host";  ## must double quoted

name: cpu
---------
key value
host    2455f1b15857
host    e7af7803cfbd
```

## Field related
```
> show field keys from cpu
name: cpu
---------
fieldKey        fieldType
usage_guest     float
usage_guest_nice    float
usage_idle      float
usage_iowait        float
usage_irq       float
usage_nice      float
usage_softirq       float
usage_steal     float
usage_system        float
usage_user      float

```
## Insert data
```
Insert temp,machine=unit42,type=assembly external=25,internal=27 [timestamp];
Insert cpu,host=serverA,region=us_west value=0.64
```

## Query data
```
select * from <measurement>
SELECT * FROM /.*/ LIMIT 1
SELECT * FROM cpu_load_short
SELECT * FROM cpu_load_short WHERE value > 0.9


select * from <measurement> where <tag key> = <tag value>;
select * from <measurement> where time < now();
select * from temp where time < now() - 10m;
select * from temp where time < '2016-10-21';

select * from "<measurement>" if name of measurement has special character
```


## Subscription
subscriptions tell influxdb to send all the data it receives to kapacitor or other third parties  

```
show subscriptions
use _internal

CREATE SUBSCRIPTION "sub0" ON "mydb"."autogen" DESTINATIONS ANY 'udp://h1.example.com:9090', 'udp://h2.example.com:9090'
drop subscription "kapacitor-a39af078-fa8d-4ada-b5d8-dc7cc8d65b7c" on _internal.monitor;
```

## Functions

|Aggregations|    Selectors|   Transformations|
|:---:|:---:|:---:|
|COUNT()| BOTTOM()  |  CEILING()|
|DISTINCT()|  FIRST()| DERIVATIVE()|
|INTEGRAL()|  LAST()|  DIFFERENCE()|
|MEAN() | MAX()  | FLOOR()|
|MEDIAN() |   MIN() |  HISTOGRAM() |
|SUM() |  PERCENTILE() |   NON\_NEGATIVE\_DERIVATIVE()|
|TOP()   |STDDEV()|

## Continuous query

```
show continuous queries
drop continuous query <id>

CREATE CONTINUOUS QUERY cq_30m ON testDB BEGIN SELECT mean(temperature) INTO weather30m FROM weather GROUP BY time(30m) END
    cq_30m：连续查询的名字
    testDB：具体的数据库名
    mean(temperature): 算平均温度
    weather： 当前表名
    weather30m： 存新数据的表名
    30m：时间间隔为30分钟
```
