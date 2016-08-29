## Installation

## Usage

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

