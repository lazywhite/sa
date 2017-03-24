[doc](https://www.percona.com/doc/percona-xtrabackup/2.1/innobackupex/innobackupex_script.html)
[案例](http://m.blog.chinaunix.net/uid-10661836-id-4099769.html)
[blog](http://osrun.blog.51cto.com/608651/1613432)

## Tips
1. xtrabackup为Point-In-Time物理热备，会备份binlog, 支持加密备份
2. xtrabackup支持Innodb/Xtradb/MyISAM存储引擎
3. 恢复备份需要先apply-log

## Install
```
$ wget http://www.percona.com/downloads/percona-release/redhat/0.1-4/\
percona-release-0.1-4.noarch.rpm
$ rpm -ivH percona-release-0.1-4.noarch.rpm
yum install percona-xtrabackup-24

grant select,show view,Replication client,SUPER,RELOAD  on *.* to 'backup'@'127.0.0.1' identified by 'passwd';
flush privileges;
```

## 全量备份
```
#!/bin/sh
v_date=`date "+%Y-%m-%d-%H-%M"`

innobackupex --user=root --host=192.168.244.22 --password='mysql' --tmpdir=/var --stream=tar ./ 2>/data/backup/xtrabackup$v_date.log  |gzip > /data/backup/backup$v_date.tar.gz
```


## 全量恢复备份
```
1. 关闭mysqld进程
2. 清空datadir
3. innobackupex --apply-log --use-memory=4G /path/to/backup_dir
4. innobackupex --copy-back /path/to/bakcup_dir
5. chown -R mysql:mysql /path/to/data_dir
6. service mysqld start

```

## 增量备份
```
innobackupex --host=127.0.0.1  --port=3306 --user=backup --password='passwd' --no-lock --defaults-file=/usr/local/services/mysql/etc/my.cnf  --incremental /data/backup/ --incremental-dir /data/backup/2014-11-18_15-52-4
```

## 增量恢复
```
恢复最后一个incremental不需"--redo-only"选项
--redo-only should be used when merging all incrementals except the last one. That’s why the previous line doesn’t contain the --redo-only option. Even if the --redo-only was used on the last step, backup would still be consistent but in that case server would perform the rollback phase.
```

