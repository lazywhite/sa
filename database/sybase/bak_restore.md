## Requirements
1. page-size must be same   
2. original database charset must be same   ; cp936
3. original database device size must be same  
4. original database log device size must be same  
5. os version, sybase db version should be same

6. sort order should be checked ; utf8

## Procedure
1. create db_device, log_device with same size as source database
2. create database <dbname> on these devices
3. run commands in "isql"  


```
1>use master
2>go
1> load database <dbname> from '/path/to/dump.dat'
2> go

1> online database '<dbname>'
2> go

Couldn't find an available partition descriptor. Raise the value of the configuration parameter 'number of open partitions' for more partition descriptors.


restart the server 
```
