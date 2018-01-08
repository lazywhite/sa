## Overview
```
version: 3.4.11
/etc/hosts
    192.168.122.10 zoo1
    192.168.122.11 zoo2
    192.168.122.12 zoo3
```
## cluster mode
```
1. install jdk  
    export JAVA_HOME=/usr/local/jdk
2. install zookeeper
    tar xf zookeeper.tar.gz -C /usr/local
    export PATH=/usr/local/zookeeper/bin:/usr/local/jdk/bin:$PATH

3. run script
```
mkdir /var/lib/zookeeper
echo '1' > $dataDir/myid   # server.<myid> 
```
4. modify etc/zoo.cfg
    initLimit=10
    syncLimit=5
    dataDir=/var/lib/zookeeper
    clientPort=2181

    server.1=zoo1:2888:3888
    server.2=zoo2:2888:3888
    server.3=zoo3:2888:3888


5. set log path
    bin/zkEnv.sh  
        mkdir /var/log/zookeeper
        ZOO_LOG_DIR=/var/log/zookeeper

6. start cluster 
    every node
        zkServer.sh start-foreground # debug 
        zkServer.sh start
```
