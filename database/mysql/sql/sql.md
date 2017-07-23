## 子查询
### where 子查询（无需别名)
```
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
```
### From子句子查询(需要别名)
```
SELECT ... FROM (subquery) AS name
```
### EXIST
```
SELECT * FROM article WHERE EXISTS (SELECT * FROM user WHERE article.uid = user.uid)
```

## Group by<colume1>[<column2]<colume1>[<column2<colume1>[<column2]<colume1>[<column2]] 
```
select .. group by column1, column2;  select 的字段至少包含一个group by的字段, 其他字段是聚合函数
如果column1有m种， column2有n种， 则最后出现m * n 行

where与having的区别
1. 作用的对象不同。WHERE 子句作用于表和视图，HAVING 子句作用于组。
2. WHERE 在分组和聚集计算之前选取输入行（因此，它控制哪些行进入聚集计算）， 而 HAVING 在分组和聚集之后选取分组的行。因此，WHERE 子句不能包含聚集函数； 因为试图用聚集函数判断那些行输入给聚集运算是没有意义的。 相反，HAVING 子句总是包含聚集函数。

select job, sum(salary) from emp group by job;
select deptno, count(*) from emp group by deptno having count(*) > 3; 
select deptno, avg(salary) from emp 
    where job <> '程序猿' 
        group by deptno 
            having avg(salary) > 1000 
                order by avg(salary) desc;


select deptno,count(*), avg(salary) from emp 
    where salary between 10000 and 20000 
        group by deptno 
            having count(*) > 1 and deptno <> 10 and avg(salary) < 14000;


select * from 
    (select e.empno, e.ename, e.salary, e.deptno, f.ename mname from emp e left join emp f on e.manager = f.empno) g left join dept d 
        on g.deptno = d.deptno;


select name, count(distinct(score)) from t4 group by name;
select name, group_concat(score) from t4 group by name;

```
  
## Distinct
```
select distinct(name) from user;
select distinct name from user; 

select distinct name, age from user; 多字段去重
select count(distinct(name)) from user;
```

## Union
```
1. select语句无需别名
2. union all 不过滤重复数据

select * from article
	union [all]
select * from article
```

## LIMIT 
```
mysql> SELECT * FROM table order by id LIMIT 5,10;   [offset,]<row count>

选取某一个行到最后的内容, 提供一个非常大的row count就行
mysql> SELECT * FROM table order by id LIMIT 95, 18446744073709551615; 

```

## Foreign key
```
## 1. 创建表的同时定义外键
CREATE TABLE Persons
(
  Id_P int NOT NULL,
  LastName varchar(255) NOT NULL,
  FirstName varchar(255),
  Address varchar(255),
  City varchar(255),
  PRIMARY KEY (Id_P)
)
CREATE TABLE Orders
(
Id_O int NOT NULL,
OrderNo int NOT NULL,
Id_P int,
PRIMARY KEY (Id_O),
FOREIGN KEY (Id_P) REFERENCES Persons(Id_P)
) 


## 2. 在已存在的表中添加外键
alter table orders drop column Id_P;
alter table orders add column Id_P int not null after OrderNo;
alter table orders add constraint fk_person_id foreign key (Id_P) references Person(Id_P)
or
alter table orders add foreign key(Id_P) references Person(id);

## 3. 删除外键
show create table Orders #获得外键名称
set FOREIGN_KEY_CHECKS = 0;
alter table child drop foreign key orders_ibfk_1; 

## 4. 外键约束
外键对于子表而言, 如果父表不存在id, 则子表无法insert记录, 或update uid
外键对于父表而言, 根据约束类型不同, 会对子表产生不同影响
alter table orders add constraint fk_person_id foreign key (Id_P) references Person(Id_P) on delete <type>  on update <type>

constraint type
    on update 
        cascade: 如果父记录更新了id, 则子记录的uid会改变为新的id
        set null: 如果父记录更新id, 此时子表中有记录参考此id, 所有子记录的uid字段被设为null, 前提是uid允许为null
        restrict: 如果父记录更新id, 此时子表中有记录参考此id, 则update失败
        no action: 同restrict
    on delete
        cascade: 删除父记录时, 如果子表中有记录参考此ID, 则所有子记录被删除
        set null:  删除父记录时, 如果子表中有记录参考此ID, 则所有子记录uid设置为null
        restrict: 删除父记录时, 如果子表中有记录参考此ID, 则delete失败
        no action: 同restrict


## 5. 查看表定义的外键
select
    concat(table_name, '.', column_name) as 'foreign key',
    concat(referenced_table_name, '.', referenced_column_name) as 'references'
from
    information_schema.key_column_usage
where
    referenced_table_name is not null;
and 
    table_name = "user_info";
```
## Index
```
## 1. 查看表的索引
show index from user_info;
## 1. 删除索引
alter table user_info drop index `idx_id`;
DROP INDEX `idx_id` ON user_info;

## 2. 创建索引
create [unique|fulltext|spatial] index <index_name> on <table>(<column>[length]) [using [btree|hash]];
create index `idx_uid` on user_info(uid);
## 3. 创建联合索引
create table map_user_role(uid int , rid int,  primary key(uid, rid), foreign key(uid) references user(id), foreign key(rid) references role(id));

```
# Procedure
## create procedure
```
mysql> delimiter //
mysql> create procedure show_all_user (OUT number INT) begin select count(*) from user into number; end//
mysql> delimiter ;

mysql> set @number = 0;
mysql> call show_all_user(@number);
mysql> select @number;
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
## 1. create function
```
delimiter//
create function get_weekday(d datetime) returns varchar(30)
  begin
    declare s varchar(30);
    select weekday(d) into s;
    return concat("week index of today is: " , s);
  END;//
delimiter ;
```
## 2. function return type
```
Deterministic functions 
	always return the same result any time they are called with a specific set of input values.
Nondeterministic functions 
	may return different results each time they are called with a specific set of input values.
```
## 3. call function
```
select get_weekday(now());
```

## 4. remove function
```
Drop function if exists db.func_name
```

## 5. alter function
```
alter function <name>
```
## 6. list all function of current database
```
show function status where db = 'test'
```
## 7. view function body
```
show create function test.get_weekday
```

## While循环
```
delimiter $$　　　　// 定义结束符为 $$ 
drop procedure if exists wk; // 删除 已有的 存储过程 

create procedure wk()　　　　　　//　 创建新的存储过程 
begin 
    declare i int;　　　　　　　　　　// 变量声明 
    set i = 1;　　　　　 
    while i < 11 do 　　　　　　　　　　// 循环体 
        insert into user_profile (uid) values (i); 
        set i = i +1; 
    end while; 
end $$　　　　　　　　　　　　　　　// 结束定义语句 

// 调用 

delimiter ;　　　　　　　　　　// 先把结束符 回复为; 
call wk();
```
## Repeat循环
```
delimiter //
drop procedure if exists looppc;
create procedure looppc()
begin 
    declare i int;
    set i = 1;

    repeat 
        insert into user_profile_company (uid) values (i+1);
        set i = i + 1;
    until i >= 20

    end repeat;
end //

---- 调用
call looppc()
```

## Loop循环
```
delimiter $$
drop procedure if exists lopp;
create procedure lopp()
begin 
    declare i int ;
    set i = 1;

    lp1 : LOOP　　　　　　　　　　　　　　//  lp1 为循环体名称   LOOP 为关键字
        insert into user_profile (uid) values (i);
        set i = i+1;
        if i > 30 then
            leave lp1;　　　　　　　　　　　　　　//  离开循环体
        end if;
    end LOOP;　　　　　　　　　　　　　　//  结束循环
end $$
```

# Trigger 
## create trigger
```
create trigger c_history before update on article
  for each row
    insert into `content_history`(content_before, content_after) values (OLD.content, NEW.content)

```
## list triggers
```
show triggers [from|in <db>];
```
## remove trigger
```
drop trigger if exists c_history;
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
## remove event
```
drop event if exists <event_name>
```

# View
## create view
```
CREATE  VIEW `full` AS 
    select `article`.`id` AS `id`,`article`.`content` AS `content`,`user`.`id` AS `uid`,`user`.`name` AS `name` from 
        `article` left join `user` on `article`.`uid` = `user`.`id`
```
## show view
```
show create view <name>
```
## show database views
```
select * from information_schema.views where table_schema regexp 'test'\G

```	
##  remove view
```
drop view if exists <view name>
```

# Prepare statement (since mysql5.5)
```
mysql> prepare stmt from 'select sqrt(pow(?, 2) + pow(?, 2)) as mm';
mysql> set @a = 4;
mysql> set @b = 3;
mysql> execute stmt using @a, @b;
```


# Transaction
```
mysql> start transcation [with consistent snapshot];
mysql> savepoint <p1>;
mysql> rollback [to <p1>]
mysql> release savepoint <p1>;
mysql> commit;
```



## User操作
```
create user name;
drop user name;
Rename User name To another
Show Grants For name;
Set Password For name=Password('1234')
Set Password=Password("some");修改用户自己的密码

SHOW GRANTS FOR user@host
DROP USER 'user'@'host';
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

mysql> SET GLOBAL innodb_ft_aux_table="new_feature/articles";
mysql> SELECT * FROM information_schema.INNODB_FT_INDEX_CACHE LIMIT 20,10;
```

## Join
```
类型： 左连， 右连， 内连， 全连， 自连
1. 没有标明类型的join, 默认是inner join
2. mysql没有full join， 用left join union right join
3. inner 和 cross 在mysql中是同义词
4. Multi Left Join
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


5. 笛卡尔积 (result.rows  = emp.rows * dept.rows)
    select * from emp, dept; 
    select * from emp join dept;
    select * from emp inner join dept; 
    select * from emp cross join dept; 
   
    join on 其实就是带条件过滤的笛卡尔积
6. 自连结查询
   select e.empno, e.ename, f.ename from emp e inner join emp f on e.manager = f.empno; 

   select e.empno, e.ename, f.ename from emp e, emp f; //多表联合查询, 仅为inner join的结果

```


## SHOW usage
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
show warnings; ##当前一条命令返回结果提示 0 errors, 1 warning时查看
show engine;查看支持的引擎
show table status like 'user';
show processlist;Kill ID;

show tables like "history%";
```
## 计算索引未命中缓存的概率：
```
key_cache_miss_rate = Key_reads / Key_read_requests * 100%
```

## auto increment settings
```
auto_increment_increment (默认间隔值)
auto_increment_offset   (默认起始值)
create table tb() AUTO_INCREMENT=100 (指定起始值)
```

## select from n last row
```
select * from book_authors order by id desc limit 10;
```
## change column type
```
alter table table_name modify column_name int(5)
```
## temporary disable foreign key check
```
SET FOREIGN_KEY_CHECKS=0;
```

## Replace用法
```
replace into testTable(id, name) values(6, "hello"); 提供的column必须包含主键或者其他unique index, 没有提供值并且没有默认值的字段将以null填充
如果不存在行则直接insert， 有存在的行将先delete后insert
```

## 查询mysql server状态
```
mysql> show status;
mysql> show processlist
mysql> status;
mysql> select user()
mysql> select database()
mysql> show plugins; #可以查看支持的存储引擎
```

## 表更改

```
rename table <old_name> to <new_name>;
alter table <old_name> rename to <new_name>;
```

## 列操作
```
添加列
    alter table employee add column age int after name; ## 只有after， 没有before
    alter table employee add column age int First; ## 添加到第一列
修改列(类型， 名称等)
    alter table employee change `employee_name` `name` varchar(50) ##必须有back-quota
    alter table employee modify `name` varchar(100); # 仅修改类型
删除列
    alter table employee drop [column] employee_sex;
```

# 內建函数
## IF
```
If expr1 is TRUE (expr1 <> 0 and expr1 <> NULL) then IF() returns expr2; otherwise it returns expr3
select if(0, 'true', 'false'); -->false
select if(1, 'true', 'false'); -->true
SELECT IF(0 = FALSE, 'true', 'false'); -->true
SELECT IF(1 = TRUE, 'true', 'false');  -->true
select if("str", "true", "false"); -->false  
```

##  IFNULL函数(exp1为null，返回exp2, 否则返回exp1)
```

mysql> SELECT IFNULL(1,0);
        -> 1
mysql> SELECT IFNULL(NULL,10);
        -> 10
mysql> SELECT IFNULL(1/0,10);
        -> 10
mysql> SELECT IFNULL(1/0,'yes');
        -> 'yes'

```
## NULLIF
```
Returns NULL if expr1 = expr2 is true, otherwise returns expr1

mysql> SELECT NULLIF(1,1);
        -> NULL
mysql> SELECT NULLIF(1,2);
        -> 1
```
## ISNULL
```
If expr is NULL, ISNULL() returns 1, otherwise it returns 0.

mysql> SELECT ISNULL(1+1);
        -> 0
mysql> SELECT ISNULL(1/0);
        -> 1
```

## 日期相关函数
```
set @date = '1987-02-03 12:23:45';
mysql> SELECT year(@date);
mysql> SELECT month(@date);
mysql> SELECT day(@date);
mysql> SELECT hour(@date);
mysql> SELECT minute(@date);
mysql> SELECT second(@date);

mysql> SELECT ADDDATE('2008-01-02', 31);
        -> '2008-02-02'
mysql> SELECT CURDATE();
        -> '2008-06-13'
mysql> SELECT CURTIME();
        -> '23:50:26'
mysql> select date('2017-01-01');
+--------------------+
| date('2017-01-01') |
+--------------------+
| 2017-01-01         |
+--------------------+

datediff(exp1, exp2) --> exp1 - exp2 (in days)
    mysql> select datediff(date('2017-01-01'), date('2013-01-06'));
    +--------------------------------------------------+
    | datediff(date('2017-01-01'), date('2013-01-06')) |
    +--------------------------------------------------+
    |                                             1456 |
    +--------------------------------------------------+

mysql> SELECT DATE_ADD('2010-12-31 23:59:59', INTERVAL 1 DAY);
        -> '2011-01-01 23:59:59'

    select now()  + interval 5 day;
    select now() - interval 10 month;



ADDTIME() adds expr2 to expr1 and returns the result. expr1 is a time
or datetime expression, and expr2 is a time expression.
    mysql> SELECT ADDTIME('2007-12-31 23:59:59.999999', '1 1:1:1.000002');
            -> '2008-01-02 01:01:01.000001'
    mysql> SELECT ADDTIME('01:00:00.999999', '02:00:00.999998');
            -> '03:00:01.999997'

mysql> select date_format(date(now()), '%Y %m %d') now;
+------------+
| now        |
+------------+
| 2017 05 22 |
+------------+

weekday()Returns the weekday index for date (0 = Monday, 1 = Tuesday, ... 6 = Sunday).
    mysql> SELECT WEEKDAY('2008-02-03 22:23:00');
            -> 6


select last_day(now()); #月份最后一天
```

## 字符串相关函数
```
mysql> select concat("good ", "morning") greeting;
+----------------------------+
| greeting                   |
+----------------------------+
| good morning               |
+----------------------------+

mysql> SELECT STRCMP('text', 'text2');
        -> -1
mysql> SELECT STRCMP('text2', 'text');
        -> 1
mysql> SELECT STRCMP('text', 'text');
        -> 0


rtrim("string") ltrim("string") trim("string") 
upper("string") lower("string") 
left("string", length) right("string", length)
length("string") locate("substr", "string") 
substring("string", position, length) 


```
## 数学函数
```
avg() max() min() 
count(<column>)  返回非null的总数
floor() ceil() round()
abs() cos() exp() mod() pi() rand() sin() sqrt() tan()

聚合函数不能作为where的条件
```


## PS1
```
shell> export MYSQL_PS1="(\u@\h) [\d]> "
```

## 通配符
```
like通配符: %(任意多个） _（任意一个）
REGEXP: . * + ? \\ | [123] [a-z] {n} {n,} {n,m}

like区分大小写
    select * from piwoker where Worker_Name like binary "%bo%";
    select * from piwoker where binary Worker_Name binary "%bo%";
```

# Useful Commands
```
mysql> select now();
mysql> show full columns from <table>;
mysql> select user();
mysql> select version();
mysql> status; # show information about connected socket etc;
mysql> select user()|schema()
mysql> select floor(1.23), ceil(1.23), round(1.6666, 2),  
mysql> select 5 div 2; 整除 
mysql> select 5 / 2; 除法，结果一定是浮点数
mysql> select 5 mod 2; mod(5, 2); 求余
mysql> select repeat('a', 10); 重复10次字符串

```

## view Table
```
show create table <name>
show full columns from <name>
desc <name>

```
## delete 
```
delete from bb where id between 0 and 100;
delete from bb where id in (10, 20, 30);
```

## set pager
```
mysql> pager less
```

## safe update
```
不带where和limit的update语句禁止执行， SQL_SAFE_UPDATES 属于session变量
set SQL_SAFE_UPDATES = 1; 或者mysql --safe-updates
```

## mysql实现同构表的交集, 差集, 合集
```
求交集, 利用inner join
select s1.id, s1.name from 
    (select id, name from user where id > 50 ) s1 
    join 
    (select id, name from user where id < 160) s2 
    on s1.id = s2.id;

求差集, 利用left|right join 
select s1.id, s1.name from 
    (select id, name from user where id > 50 ) s1 
    left join 
    (select id, name from user where id < 120) s2 
    on s1.id = s2.id
    where isnull(s2.id);

求并集, 利用union, 自带去重
select * from
    (select id, name from user where id < 50
    union
    select id, name from user where id > 160) a;
```

```
+-------+--------+-------+
| name  | course | score |
+-------+--------+-------+
| bob   | 语文   |   100 |
| bob   | 数学   |   100 |
| bob   | 英语   |   100 |
| alice | 英语   |    10 |
| alice | 数学   |    10 |
| alice | 语文   |    10 |
+-------+--------+-------+

+-------+--------+--------+--------+
| name  | 语文   | 数学   | 英语   |
+-------+--------+--------+--------+
| alice |     40 |     70 |     90 |
| bob   |    100 |     80 |     50 |
+-------+--------+--------+--------+

# select name from t4 t group by name;

select name,
    (select score from t4 where name = t.name and course = '语文') 语文,
    (select score from t4 where name = t.name and course = '数学') 数学,
    (select score from t4 where name = t.name and course = '英语') 英语
    from t4 t group by t.name
```

```
select name, course, case
	when score < 60 then  '不及格'
	when score >= 60 and score < 80 then '良好'
	when score >= 80 and score <= 100 then '优秀'
    else '未知'
	end as level
	from t4
```

```
+------+------+--------+
| id   | game | result |
+------+------+--------+
|    1 | A    | WIN    |
|    2 | A    | LOSE   |
|    3 | B    | WIN    |
|    4 | B    | LOSE   |
|    5 | A    | WIN    |
|    6 | A    | LOSE   |
|    7 | B    | WIN    |
|    8 | B    | LOSE   |
+------+------+--------+

+------+------+------+
| game | win  | lose |
+------+------+------+
| A    |    2 |    2 |
| B    |    2 |    2 |
+------+------+------+


select game,
    (select count(*) from t1 where t1.game = t.game and result = 'WIN' group by game, result)win,
    (select count(*) from t1 where t1.game = t.game and result = 'LOSE' group by game, result)lose
from t1 t group by game

```

