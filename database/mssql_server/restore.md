```
[root@master mssql]# sqlcmd -Usa
Password:
1> use master
2> go
Changed database context to 'master'.
1> restore database BookMessage from disk='/home/mssql/Message-2017-02-19-20-00.db' with stats=10
2> go
Msg 3201, Level 16, State 2, Server master, Line 1
Cannot open backup device '/home/mssql/Message-2017-02-19-20-00.db'. Operating system error 2(The system cannot find the file specified.).
Msg 3013, Level 16, State 1, Server master, Line 1


## chown  mssql:mssql  </path/to/backup>

1> restore database BookMessage from disk='/home/mssql/Message-2017-02-19-20-00.db' with stats=10
2> go

```
