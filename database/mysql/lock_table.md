## topics
1. use "KILL" to terminate a session that is waiting for a table lock
2. "LOCK TABLES" and "UNLOCK TABLES" cannot be used within stored programs
3. tables in "performance schema" database cannot be locked, except the "setup_xxx" tables

## Usage
```
LOCK TABLES t1 WRITE, t2 READ;
```


## Concept
[doc](https://segmentfault.com/a/1190000004507047)


  
1. 读锁（共享锁）， 一个对象被施加读锁后，可以继续施加读锁，施加写锁的操作将会阻塞至所有读锁被释放
2. 写锁（排他锁）， 只有一个对象的写锁被释放时， 才会允许其他用户进行读写
3. 隐式锁， create  index等
4. 显式锁，  LOCK TABLE 语句


create index 隐式给表添加读锁， 只能select不能insert，update，delete
