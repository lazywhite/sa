## 物理热备流程
```
db.adminCommand({loadPlugin: 'backup_plugin'}) #可以配置为自动加载
> var d = new Date()
> var month = (d.getMonth() < 9 ? '0' : '') + (d.getMonth() + 1)
> var backupName = 'tokumx-' + d.getFullYear() + month + d.getDate()
> db.runCommand({backupStart: '/mnt/backup/' + backupName})
> db.adminCommand({backupThrottle: '10MB'}) #备份数据流速度上限
> db.adminCommand('backupStatus')  #查看备份状态
{ "ok" : 1 } 
```

## 备份
```
1. 逻辑备份: mongodump
2. 物理备份
    1. 单复制集
        参考<物理热备流程>
    2. 分片集
        集群暂停所有的写操作
        关闭balancer
        等待config repl, shard repl中有一个secondary跟master完全同步
        将以上secondary全部从复制集删除
        集群开始对外提供服务
        在所有secondary执行<物理热备流程>
        将所有secondary加入原始replSet
```


## PITR还原流程
```
//on one secondary
1. stop tokumx service
2. replace data in dbpath with backup data
3. edit config file 
add 
    rsMaintenance = true
do not add 
    fastsync = true
4. start tokumx service 
5. db.adminCommand({loadPlugin: ’pitr_plugin’})
6. db.adminCommand(
{
    recoverToPoint: 1, 
    ts: ISODate("2015-11-06T09:11:50.000Z")
}) //按时间点还原, 默认使用UTC格式
db.runCommand({recoverToPoint: 1, gtid: GTID(1, 152)}) //按gtid还原

7. on Master,  rs.remove("mongo2:27017") #防止secondary继续同步
8. edit secondary config file
remove 
    replSet=kok
    rsMaintanence=true
9. start tokumx service, it will contain snapshot data
```
