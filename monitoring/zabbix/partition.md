[zabbix partition doc](https://www.zabbix.org/wiki/Docs/howto/mysql_partition)

## 1. modify index
```
## zabbix 3.2.x 跳过此步骤
mysql> Alter table history_text drop primary key, add index (id), drop index history_text_2, add index history_text_2 (itemid, id);

mysql> Alter table history_log drop primary key, add index (id), drop index history_log_2, add index history_log_2 (itemid, id);

```

## 2. create partitions
 
```
1. 导入partition.sql
2. crontab
    0 2 */10 * * /usr/bin/mysql -h127.0.0.1 -uroot -pdbroot zabbix -e "call partition_maintenance_all('zabbix')">/dev/null 2>&1  #自动创建partition

```

## 3. housekeeping changes
```
管理
	一般
		管家
			历史记录
				uncheck 开启内部管家
				check 覆盖监控项历史期间
				数据存储时间（天） 28
			趋势
				uncheck 开启内部管家
				check 覆盖监控项历史期间
				数据存储时间（天） 730
```				

