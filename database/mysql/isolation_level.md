[Doc](http://anjianshi.net/post/yan-jiu-bi-ji/db_isolation)
  
## 脏读
```
其他事务进行了回滚，我们就相当于读到了数据库中不再存在的数据（也就是“脏数据”）。

总结: 读到了其他事务中未提交的操作, 隔离级别是read-uncommitted时会发生
```
  
## 幻读

```
是指将同一条 SELECT 语句执行两次，得到了不同的“数据集”（就是说两次返回的不是同一批数据）。

SELECT id FROM test;    =>  1,2,5
SELECT id FROM test;    =>  1,2,5,6 

总结： 读到了其他事务提交的insert或者delete, 隔离级别是read-committed会发生
```
## 不可重读
```
还是将一条 SELECT 语句执行两次，某个特定的条目在这两次查询中返回的值不一样，就叫“不可重复读”。

SELECT id, name FROM test;    =>   (1,"n1"), (2, "n2), (5, "n5")
SELECT id, name FROM test;    =>   (1, "n1"), (2, "David"), (5, "n5")

总结： 读到了其他事务提交的update, 隔离级别是read-committed会发生
```



## 隔离级别
```
1. Read uncommitted（未提交读）
这是最宽松的级别。其他事务对数据进行的任意更改就算没提交，也会立刻反应到当前事务中
所有读现象都可能出现在这个级别中
2. Read committed（提交读）
此级别中，其他事务对数据进行的更改只要一提交，就可以在当前事务中读取到。因此会出现“不可重复读”和“幻读”。
3. Repeatable Read(可重读)
其他事务对某行数据的更改无论提交没提交，都不会反应到当前事务中
会出现幻读 也就是其他事务中插入的新数据，允许出现在当前事务里。
4 Serializable
此级别下的事务必须以串行的方式被执行，或者至少是串行等价的，否则会以报错的形式结束并回滚。
“串行”也就是一个接一个的运行，这种情况下一个事务当然不会被其他事务干扰。
“串行等价”的意思就是：两个/多个事务就算同时运行（并行），得到的结果也和一个接一个的运行（串行）一样
```


## Topic
```
MySQL 的默认事务级别是 Repeatable read；PG 则是 Read committed

mysql repeatable read级别采用MVCC， 避免所有情况
```

## 操作
```
select @@tx_isolation; 查看当前隔离级别
set tx_isolation = "read-uncommitted"|"read-committed"|"repeatable-read" 仅对当前session有效
```
