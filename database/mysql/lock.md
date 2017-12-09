## 锁的种类
```
锁定范围
    表锁: 不容易发生死锁， 并发度较低
    页锁: 介于表锁与行锁之间
    行锁: 最容易发生死锁

间隙锁: 
    范围查询时会给符合条件的所有行加锁
    update table set col = new where id > 10;
自增锁: 
    有auto_increment字段, 当前事务insert必须等待其他事务的insert完成

人为干预
    隐式锁
        create index
    显式锁
        LOCK TABLES t1 WRITE, t2 READ;
        flush tables <tbname> READ;

        unlock tables;

        lock_type
            read
                拿到读锁的会话可以从表中读数据, 不能写数据
                多个会话可同时拿到读锁
                innodb 中read local 等价于 read
                
            write
                拿到写锁的会话可从表中读写数据
                其他会话无法访问表
                在写锁释放前, 其他会话无法获取锁
                LOW_PRIORITY在mysql5.6.5后已失效
```


## 查看锁状态  ```
show status like 'innodb_row_lock%';
show engine innodb status\G
select * from information_schema.innodb_lock_waits;
innotop
```


## select for update
```
假设有个表单products ，里面有id跟name二个栏位，id是主键。

例1: (明确指定主键，并且有此笔资料，row lock)

SELECT * FROM products WHERE id='3' FOR UPDATE;

SELECT * FROM products WHERE id='3' and type=1 FOR UPDATE;

例2: (明确指定主键，若查无此笔资料，无lock)

SELECT * FROM products WHERE id='-1' FOR UPDATE;

例2: (无主键，table lock)

SELECT * FROM products WHERE name='Mouse' FOR UPDATE;

例3: (主键不明确，table lock)

SELECT * FROM products WHERE id<>'3' FOR UPDATE;

例4: (主键不明确，table lock)

SELECT * FROM products WHERE id LIKE '3' FOR UPDATE;
注1: FOR UPDATE仅适用于InnoDB，且必须在交易区块(BEGIN/COMMIT)中才能生效。
    
```

## Topics
1. use "KILL" to terminate a session that is waiting for a table lock
2. "LOCK TABLES" and "UNLOCK TABLES" cannot be used within stored programs
3. tables in "performance schema" database cannot be locked, except the "setup_xxx" tables
