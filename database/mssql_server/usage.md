
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

## desc table
```
sp_help <table>
```

## show columns
```
sp_columns <table>
```


## Topic
1. [数据库的分离和附加](https://msdn.microsoft.com/zh-sg/library/ms190794.aspx)  
2. SQLServer table name 区分大小写, 而mysql在linux平台默认区分大小写, 可以设置不区分  
