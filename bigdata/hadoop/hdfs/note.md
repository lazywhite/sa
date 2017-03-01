## Topic
### 1. change default block size  
data is devided into "block", default block size is "128MB"   

```
hadoop fs -D dfs.blocksize=268435456 -copyFromLocal /hirw-starterkit/hdfs/commands/dwp-payments-april10.csv blksize/dwp-payments-april10_256MB.csv 
```
