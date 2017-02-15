## connect
```
sqlcmd -H <hostname> -U <sa>
```

# show databases
```
EXEC sp_databases
go
```

## show tables
```
use tempdb
go

exec sp_tables
go
```


## Topic
1. [数据库的分离和附加](https://msdn.microsoft.com/zh-sg/library/ms190794.aspx)
