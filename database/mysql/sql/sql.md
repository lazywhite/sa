# Database
## subquery
### 标量(单一值)
SELECT * FROM article WHERE uid = (SELECT uid FROM user WHERE status=1 ORDER BY uid DESC LIMIT 1)
### N行一列
#### IN
SELECT * FROM article WHERE uid IN(SELECT uid FROM user WHERE status=1)
#### ANY
SELECT s1 FROM table1 WHERE s1 > ANY (SELECT s2 FROM table2)
#### ALL
SELECT s1 FROM table1 WHERE s1 > ALL (SELECT s2 FROM table2)
### N列一行
SELECT * FROM table1 WHERE (1,2) = (SELECT column1, column2 FROM table2)
SELECT * FROM article WHERE (title,content,uid) = (SELECT title,content,uid FROM blog WHERE bid=2)
### N行N列(表)
SELECT * FROM article WHERE (title,content,uid) IN (SELECT title,content,uid FROM blog)
### From子句子查询
SELECT ... FROM (subquery) AS name
### EXIST
SELECT * FROM article WHERE EXISTS (SELECT * FROM user WHERE article.uid = user.uid)

## Join 拼接表
```
left join 
right join
inner join
```
# Mathmatic function
```
avg()
max()
min()
count()
```
  
# Union
UNION 用于把来自多个 SELECT 语句的结果组合到一个结果集合, 自带去重  
union all 不过滤重复数据


## limit 
```
mysql> SELECT * FROM table LIMIT 5,10;   [offset,]<row count>
mysql> SELECT * FROM table LIMIT 95, 18446744073709551615; skip "offset" to end
just provide a very large number to "row count"
```



# Variable
```
1. local variable used in stored program
create_procedure> declare Number int;
2. global system variable
mysql>  set GLOBAL max_connections = 1000;
3. session variable, can always be used before connection closed
mysql>  set SESSION max_connections = 1000, @@sql_mode = 'TRADITIONAL';
4. session-specified user variable
mysql>  set @x = 10;
```

# Procedure
## create procedure
```
mysql> delimiter //
mysql> create procedure show_all_user (OUT number INT) begin select count(*) from user into number; end//
mysql> delimiter ;
mysql> call show_all_user(@number);
```
## remove procedure
```
mysql> Drop procedure <name>;
```
## list procedures
```
show procedure status where db = 'zabbix';
```
## view procedure
```
show create procedure <name>
```

# Function
## create function
create function hello(s char(20)) returns char(50) deterministic return concat('hello ', s, '!');
## function return type
Deterministic functions always return the same result any time they are called with a specific set of input values.
Nondeterministic functions may return different results each time they are called with a specific set of input values.
## use function
select hello('world');

## remove function
Drop function <name>

## alter function
alter function <name>

# Useful Commands
```
mysql> select now();
mysql> show full columns from <table>;
mysql> select user();
mysql> select version();
mysql> show plugins;
mysql> status; # show information about connected socket etc;
mysql> select user()|schema()
mysql> select floor(1.23), ceil(1.23), round(1.6666, 2),  
mysql> select 5 div 2;  5 / 2;
mysql> select 5 mod 2; mod(5, 2);

mysql> select ifnull(<exp1>, <exp2>);
```

# Tips
## disable auto-reconnect
variable lost with connection
mysql --skip-reconnect

## safe update
mysql --safe-updates

## PS1
```
shell> export MYSQL_PS1="(\u@\h) [\d]> "
```
# Trigger 
## create trigger
```
mysql> create table account (acct_num INT, amount DECIMAL(10, 2));
mysql> create trigger ins_sum BEFORE INSERT ON acount
->      FOR EACH ROW set @sum = @sum + NEW.amount;

mysql> set @sum = 0 ;
mysql> INSERT INTO account VALUES(137,14.98),(141,1937.50),(97,-100.00); 
mysql> SELECT @sum AS 'Total amount inserted';
```

# Event Scheduler
## enable or disable event scheduler thread;
```
mysql> set global event_scheduler = ON;
```
## create event
```
CREATE DEFINER=`admin`@`%` EVENT `Event_t_log`
    ON SCHEDULE EVERY 1 DAY STARTS '2014-10-08 00:00:01' ON COMPLETION NOT PRESERVE ENABLE
    DO 
        CALL sp_t_log();

CREATE EVENT myevent
    ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
    DO
      UPDATE myschema.mytable SET mycol = mycol + 1;
```

## grant priviledges
```
mysql> grant event on myschema.* to jon@localhost;
//The EVENT privilege has global or schema-level scope.
```

## enable or disable one event
```
mysql> Alter event <name> disable/enable;
```
## view event
```
mysql> show events;
```

# View
## create view
create view <name> as select * from test;
## show view
show create view <name>
## show all views
select * from views where TABLE_SCHEMA regexp 'test'\G


# Prepare statement (since mysql5.5)
mysql> prepare stmt from 'select sqrt(pow(?, 2) + pow(?, 2)) as mm';
mysql> set @a = 4;
mysql> set @b = 3;
mysql> execute stmt using @a, @b;

# Declare

should be in a compound statement{ begin...end}
declare variable type [default Value]


# Flow control

select count( distinct user_id ) from T_USER_CHARGE where create_ts > DATE('2015-11-10') and create_ts < DATE('2015-11-11');

select count(*) from T_USER where  not isnull(device_type);


# transaction
```
mysql> start transcation [with consistent snapshot];
mysql> savepoint <p1>;
mysql> rollback [to <p1>]
mysql> release savepoint <p1>;
mysql> commit;
```

# change metadata
```
mysql>  alter table gg add primary key (id);
```

# 差集
mysql> select user from nn where user not in (select user from mysql.user) ;

# JSON datatype
JSON columns cannot have a default value.
JSON columns cannot be indexed

## Alter table
```
ALTER TABLE tbl_name MODIFY COLUMN col_name BIGINT;
RENAME TABLE tbl_name TO new_tbl_name, tbl_name2 TO new_tbl_name2;
```



# Datatype:
## 1.string:
```
char:fixed-length 1-256 characters
enum:up to 64K string
text:max size 64K text 
mediumtext:max size 16K text;
longtext:up to 4G text;
tinytext:up to 255 byte;
set:up to 64 strings;
varchar:same as char
```
## 2.number
```
bit:1-64 byte
int:
bigint:
mediumint:
Real:4-byte floating values;
float:single-precision floating point 
double:double-precision floating point
decimal:可变精度浮点数
smallint:0-32767
tinyint:-128 127 or 256
```
## 3.boolean:0 or 1
## 4.data and time 
```
date:YYY-MM-DD
datetime:combination of date and time
time:HH-MM-SS
year:
```
## 5.binary datatype
```
blob:max length 64k
mediumblob:max length 16MB
longblob:max length 4GB
tinyblob:max length 256 bytes;
```
```
通配符: *  % _
REGEXP: . * + ? \\ | [123] [a-z] {n} {n,} {n,m}
fully qualified name;
注释:-- ,#
mariadb>\. filename 在交互模式下运行脚本
```

## Select
```
select column1,column2... from table;select * from table;
select distinct  :唯一的
select column1 from table limit 5;默认第一行为row0
select column1 from table limit 5,5;从第6行开始的持续5行
select column1 from table order by column1 desc;
select column1 from table where column2='sth'
select column1 from table where column2 between A and B
select column1 from table where column2 IS NULL
select column1 from table where column2='A' and|or column3='B'
select columns from table where column1 IN (start,end) | NOT IN
select columns from table where column1 like 'jet%'
select columns from table where column1 REGEXP 'string'
like 后跟的规则不加通配符的话表示完全匹配
```

```
1.text manipulation function
rtrim() ltrim() trim() upper() lower() left() length() locate() soundex()
substring() 
2.date and time manipulation funciton
adddate() addtime() curdate() curtime() date() datediff() date_add()
date_format() day() dayofweek() hour() minute() month() now() second() time()
year()
3.numeric manipulation funcitons
abs() cos() exp() mod() pi() rand() sin() sqrt() tan()
4.aggregate functions 集合,聚集
avg() count() max() min() sum()


data grouping
select id,count(*) from table group by id;

```
full-text search 
boolean-text search  

Insert:
full-insert,partial-insert,multiple-insert,insert a result of a query;
partial-insert 表的列必须允许NULL或者有默认值,否则不能部分插入
多插入insert into table values (1,2,3,4),(5,6,7,8)
将查询结果插入表,insert into table1 (column1,column2....)
select column1,column2... from table2
---------------------------------------
update
update table set column1='A' where column2='B'

------------------
delete
delete from table where column1='A'
一定以主键为选择标准,删之前可以用select看一下

mariaDB无法undo

auto_increment  相当于一个会变化的默认值,可不手动赋值


DEFAULT 不能为函数,只能为常量->数字或字符串


## Foreign key
```
在支持事物管理的引擎下创建的表,创建外键才有意义
a table using one engine cannot have a foreign key referring to a
table that uses another engine
```

# Table
## 1. Create table
```
create table Table (
id int(8),name varchar(24) NOT NULL,
quality int(8) NOT NULL DEFAULT 1,
PRIMARY KEY (id));
```
## 2. Alter table
```
alter table :update the defination of table

Alter Table table Add column3 varchar(20)
Alter Table table Drop Column column1;
Alter 添加 Foreign Key
Drop Table table; 与 Delete * from table的区别
Rename Table table1 TO table1_backup,table2 TO table2_backup;

create index [type] on table(column)
```

## View
```
VIEW :其实只是一个query command,返回一个虚拟的表
new view 不能与table或其他view重名
Create View name;
Show Create View name;显示创建view的语句
Drop View name;
Create OR Replace View name;更新一个view

create view ST AS select Concat(RTrim(vend_name),'(',RTrim(vend_country),')')
AS vend_title From vendors Order By vend_name;
```
## Cursor
```
Declare name Cursor For select column from table;
open name;close name;
```
## Trigger
```
trigger of Insert Delete Update
```
## Transaction
```
transaction : could only be used for Insert Delete Update
Transaction processing is used to maintain database integrity by ensuring that
batches of MariaDB SQL operations execute completely or not at all

MariaDB SQL statements are usually executed and written directly to the data-
base tables. This is known as an implicit commit—the commit (write or save)
operation happens automatically.
Within a transaction block, however, commits do not occur implicitly. To
force an explicit commit, the COMMIT statement is used

savepoint name;rollback to name;

```

## User 
```
create user name;
drop user name;
Rename User name To another
Show Grants For name;
Set Password For name=Password('1234')
Set Password=Password("some");修改用户自己的密码
```

## Full-text search 
```
my.ini
    ft_min_word_len = 2

CREATE TABLE articles (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    title VARCHAR(200),
    body TEXT,
    FULLTEXT (title,body)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO articles (title,body) VALUES
    ('MySQL Tutorial','DBMS stands for DataBase ...'),
    ('How To Use MySQL Well','After you went through a ...'),
    ('Optimizing MySQL','In this tutorial we will show ...'),
    ('1001 MySQL Tricks','1. Never run mysqld as root. 2. ...'),
    ('MySQL vs. YourSQL','In the following database comparison ...'),
    ('MySQL Security','When configured properly, MySQL ...');

SELECT * FROM articles
    WHERE MATCH (title,body) AGAINST ('database');

1. 只有权重低于50%的才会出现在结果中

SELECT * FROM articles WHERE MATCH (title,body)
     AGAINST ('well' IN BOOLEAN MODE );

SELECT * FROM articles WHERE MATCH (title,body)
     AGAINST ('+apple -banana' IN BOOLEAN MODE);  //+表示包含，-表示不包含

SELECT * FROM articles WHERE MATCH (title,body)
     AGAINST ('apple banana' IN BOOLEAN MODE); //空格表示or

```

## 中文全文索引
mysql5.7 支持ngram插件来做中文分词，MyISAM和Innodb可用  
[doc](http://www.actionsky.com/docs/archives/163)
```

[mysqld]
ngram_token_size=2


CREATE TABLE articles (
            id INTUNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
            titleVARCHAR(200),
            body TEXT,
            FULLTEXT (title,body) WITH PARSER ngram
        ) ENGINE=InnoDBCHARACTER SET utf8mb4;

mysql> SETGLOBAL innodb_ft_aux_table="new_feature/articles";
mysql> SELECT *FROM information_schema.INNODB_FT_INDEX_CACHE LIMIT 20,10;


## String function
```
sql 对大小写不敏感

substring_index(username, '@', 1)
TRIM(字串): 将所有字串起头或结尾的空白移除
LTRIM(字串): 将所有字串起头的空白移除.
RTRIM(字串): 将所有字串结尾的空白移除.
```

## Multi Left Join
```
CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `user_info` (
  `id` int(11) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `location` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `content` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;


select * from user as a inner join article as b on (a.id = b.uid);

select user.name, article.content, user_info.location from user left join article on (user.id = article.uid) left join user_info on (user.id = user_info.id)

```

# Topic
## 1. "SHOW" useful command
```
show create database test;
show databases;
show tables;
show variables;
show global status;
show columns from db.user;
show grants for User;
show index from db.table;
show [full] processlist;
show table status [like 'tb']\G;
show privileges;
show create database DBname
show create table TBname;
show [storage] engines;
show innodb status;
show warnings;
show master status; 查看主的状态
show slave status\G; 查看从的状态
show processlist; 查看mysql的进程状态信息
show master logs; 查看主的日志

show full columns from table;
show status;
show create database mysql;
show create table user;
show grants;
show errors;
show warnings;
show engine;查看支持的引擎
show table status like 'user';
show processlist;Kill ID;

show tables like "history%";
```
## 2. 计算索引未命中缓存的概率：
```
key_cache_miss_rate = Key_reads / Key_read_requests * 100%
```

## 3. auto increment settings
```
auto_increment_increment (默认间隔值)
auto_increment_offset   (默认起始值)
create table tb() AUTO_INCREMENT=100 (指定起始值)
```

