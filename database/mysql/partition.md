```
分类
	list
		list column
	range
		list range
	hash @linear
		key @linear
	组合分区

```
## 1. List Partition
```
适用情况: 某个字段所有取值是已知的
list(expression) 
	expression必须基于单个字段, 并且返回一个int
	例子: list(year(separeted))

CREATE TABLE employees (
    id INT NOT NULL,
    fname VARCHAR(30),
    lname VARCHAR(30),
    hired DATE NOT NULL DEFAULT '1970-01-01',
    separated DATE NOT NULL DEFAULT '9999-12-31',
    job_code INT,
    store_id INT
)
PARTITION BY LIST(store_id) (
    PARTITION pNorth VALUES IN (3,5,6,9,17),
    PARTITION pEast VALUES IN (1,2,10,11,19,20),
    PARTITION pWest VALUES IN (4,12,13,14,18),
    PARTITION pCentral VALUES IN (7,8,15,16)
);
```
## 2. Range Partition
```
适用情况: 某个字段的取值是均匀分布的, 并且不会超出最大值

range(expression) 
	expression最后的取值一定是int

CREATE TABLE quarterly_report_status (
    report_id INT NOT NULL,
    report_status VARCHAR(20) NOT NULL,
    report_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)
PARTITION BY RANGE ( UNIX_TIMESTAMP(report_updated) ) (
    PARTITION p0 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-01-01 00:00:00') ),
    PARTITION p1 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-04-01 00:00:00') ),
    PARTITION p2 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-07-01 00:00:00') ),
    PARTITION p3 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-10-01 00:00:00') ),
    PARTITION p9 VALUES LESS THAN (MAXVALUE)
);

CREATE TABLE members (
    firstname VARCHAR(25) NOT NULL,
    lastname VARCHAR(25) NOT NULL,
    username VARCHAR(16) NOT NULL,
    email VARCHAR(35),
    joined DATE NOT NULL
)
PARTITION BY RANGE( YEAR(joined) ) (
    PARTITION p0 VALUES LESS THAN (1960),
    PARTITION p1 VALUES LESS THAN (1970),
    PARTITION p2 VALUES LESS THAN (1980),
    PARTITION p3 VALUES LESS THAN (1990),
    PARTITION p4 VALUES LESS THAN MAXVALUE
);
```
## 3. Hash Partition

```
适用情况: 
normal hash 
linear hash两类
	line hash不再直接拿num做hash, 拿比num大的最小的2的指数来做hash
	V = POWER(2, CEILING(LOG(2, num))) )) )

hash(expr)
	expr必须基于单个字段的值, 并且返回一个int
	hash(year(hired))

CREATE TABLE employees (
    id INT NOT NULL,
    fname VARCHAR(30),
    lname VARCHAR(30),
    hired DATE NOT NULL DEFAULT '1970-01-01',
    separated DATE NOT NULL DEFAULT '9999-12-31',
    job_code INT,
    store_id INT
)
PARTITION BY HASH( YEAR(hired) )
-- PARTITION BY LINEAR HASH( YEAR(hired) )
PARTITIONS 4;
```

## 4. column partition
### 4.1 range columns partition
```
range partition的变种, 好处是可以使用多个字段作为分区依据, 并且不再局限于int类型

CREATE TABLE customers_3 (
    first_name VARCHAR(25),
    last_name VARCHAR(25),
    street_1 VARCHAR(30),
    street_2 VARCHAR(30),
    city VARCHAR(15),
    renewal DATE
)
PARTITION BY RANGE COLUMNS(renewal) (
    PARTITION pWeek_1 VALUES LESS THAN('2010-02-09'),
    PARTITION pWeek_2 VALUES LESS THAN('2010-02-15'),
    PARTITION pWeek_3 VALUES LESS THAN('2010-02-22'),
    PARTITION pWeek_4 VALUES LESS THAN('2010-03-01')
);
```
### 4.2 list columns partition
```
list partition变种 好处
	1. 可以使用多个字段作为分区依据, 
	2. 不再局限于int类型, 可以使用string, date, datetime类型的字段

CREATE TABLE customers_2 (
    first_name VARCHAR(25),
    last_name VARCHAR(25),
    street_1 VARCHAR(30),
    street_2 VARCHAR(30),
    city VARCHAR(15),
    renewal DATE
)
PARTITION BY LIST COLUMNS(renewal) (
    PARTITION pWeek_1 VALUES IN('2010-02-01', '2010-02-02', '2010-02-03',
        '2010-02-04', '2010-02-05', '2010-02-06', '2010-02-07'),
    PARTITION pWeek_2 VALUES IN('2010-02-08', '2010-02-09', '2010-02-10',
        '2010-02-11', '2010-02-12', '2010-02-13', '2010-02-14'),
    PARTITION pWeek_3 VALUES IN('2010-02-15', '2010-02-16', '2010-02-17',
        '2010-02-18', '2010-02-19', '2010-02-20', '2010-02-21'),
    PARTITION pWeek_4 VALUES IN('2010-02-22', '2010-02-23', '2010-02-24',
        '2010-02-25', '2010-02-26', '2010-02-27', '2010-02-28')
);
```

## 5. Key
```
分为key和linear key两类

最终采用对表的primary key 采用 md5() 或password() 的算法取得的hash值来分区
1. 不接受用户提供的expression, 而采用索引
2. key()默认使用primary key, 如果没有primary key, 则使用unique key, 如果unique key没有声明为not null, 则分区失败
3. 主键不是必须为int类型, 可以是varchar类型

CREATE TABLE tk (
    col1 INT NOT NULL,
    col2 CHAR(5),
    col3 DATE
)
PARTITION BY LINEAR KEY (col1)
PARTITIONS 3;
```

## 5. 组合分区
```
CREATE TABLE ts (id INT, purchased DATE)
    PARTITION BY RANGE( YEAR(purchased) )
    SUBPARTITION BY HASH( TO_DAYS(purchased) ) (
        PARTITION p0 VALUES LESS THAN (1990) (
            SUBPARTITION s0,
            SUBPARTITION s1
        ),
        PARTITION p1 VALUES LESS THAN (2000) (
            SUBPARTITION s2,
            SUBPARTITION s3
        ),
        PARTITION p2 VALUES LESS THAN MAXVALUE (
            SUBPARTITION s4,
            SUBPARTITION s5
        )
    );
```


## 分区操作
```
create partition 
    "ALTER TABLE t1 ADD PARTITION (PARTITION p3 VALUES LESS THAN (2002));"

list partitions 
    show create table <tbname>

    SELECT PARTITION_NAME, TABLE_ROWS
        FROM INFORMATION_SCHEMA.PARTITIONS
            WHERE TABLE_NAME = 't1';
drop partition 
    alter table <tbname> drop partition <ptname>

check partition 
    explain partitions select * from location where device_id = 1;
```
## topic
1. 对已有大量数据的表进行分区,  将原数据备份， 创建新的带分区的表， 最后还原
2. 在已按range划分的分区表中添加新分区，只能继续增加， 不能减小
3. 对于range和list, 需要手动指定分区的规则, hash不需要, 只需要指定分区数量
