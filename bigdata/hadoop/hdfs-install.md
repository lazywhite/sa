## 单节点模式

```
hadoop namenode -format
start-dfs.sh

hadoop fs -ls <args>
hadoop fs -mkdir /user/input
hadoop fs -put /home/access.log /user/input
hadoop fs -ls /user/input
hadoop fs -cat /user/output/outfile
hadoop fs -get /user/output/ /home/hadoop_tp/

stop-dfs.sh

hdfs dfs -setrep 2 passwd 
```

## 分布式模式
```
1. 规定slave node列表
    $HADOOP_HOME/etc/hadoop/slaves
        localhost
        datanode1
        datanode2

2. 所有data node配置ssh公钥免密码登录
3. namenode# start-dfs.sh
```
