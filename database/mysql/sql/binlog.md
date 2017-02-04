1、手动删除mysql bin文件:
purge master logs to 'mysql-bin.xxx'; 
2、修改配置文件my.conf
expire-logs-days=5
3、删除所有bin-log(慎用,清空日志同时会清空主的授权信息)：
reset master;
4、删除mysql-bin.000099之前的bin-log:
purge binary logs to 'mysql-bin.000099';



mysqlbinlog --start-datetime='2015-06-05 00:00:00' --stop-datetime='2015-06-05 17:50:00' mysql-bin.000002
mysqlbinlog --start-position=764322 --stop-position=765150 mysql-bin.000002
