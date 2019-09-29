## env
```
二进制安装, 无需再编译protobuf
tez 0.9.0(需要hadoop 2.7.x, protobuf)
hadoop 2.7.1


http://tez.apache.org/install.html
```

## 安装
```
1. 下载
    http://mirrors.shu.edu.cn/apache/tez/0.9.0/
2. 上传
    cd apache-tez-0.9.0-bin/share
    hadoop fs -mkdir -p /user/tez
    hadoop fs -put tez.tar.gz /user/tez

3. hadoop所有节点部署tez
    1. 将apache-tez-0.9.0-bin.tar.gz 复制到所有节点， 并解压至/usr/local/tez/apache-tez-0.9.0-bin

    更新所有节点/path/to/hadoop/etc/hadoop/hadoop-env.sh, 添加如下内容
        TEZ_CONF_DIR=/usr/local/hadoop/etc/hadoop/tez-site.xml
        TEZ_JARS=/usr/local/tez/apache-tez-0.9.0-bin
        export HADOOP_CLASSPATH=${HADOOP_CLASSPATH}:${TEZ_CONF_DIR}:${TEZ_JARS}/*:${TEZ_JARS}/lib/*

    2. 新增/path/to/hadoop/etc/hadoop/tez-site.xml
        <configuration> 
            <property>  
                <name>tez.lib.uris</name>  
                <value>${fs.defaultFS}/user/tez/tez.tar.gz</value>  <!-- 这里指向hdfs上的tez.tar.gz包 -->  
            </property>  
            <property>  
                <name>tez.container.max.java.heap.fraction</name>  <!-- 这里是因为我机器内存不足，而添加的参数 -->  
                <value>0.2</value>  
            </property>  
        </configuration>

    3.重启hadoop所有服务

```
## 使用
```
1. hive
    临时
        hive> set hive.execution.engine=tez; 
        hive> set hive.execution.engine=mr;
    持久化,修改hive-site.xml
    <property>
        <name>hive.execution.engine</name>
        <value>tez</value>
    </property>

2. hadoop job
```

## 安装TEZ UI
```
1. 安装tomcat
2. 启用timeline server
yarn-site.xml添加如下配置， 无需重启任何服务 
    <!-- conf timeline server -->
    <property>
        <name>yarn.timeline-service.enabled</name>
        <value>true</value>
    </property>
    <property>
        <name>yarn.timeline-service.hostname</name>
        <value>tmaster</value>
    </property>
    <property>
        <name>yarn.timeline-service.http-cross-origin.enabled</name>
        <value>true</value>
    </property>
    <property>
        <name> yarn.resourcemanager.system-metrics-publisher.enabled</name>
        <value>true</value>
    </property>
    <property>
        <name>yarn.timeline-service.generic-application-history.enabled</name>
        <value>true</value>
    </property>
    <property>
        <description>Address for the Timeline server to start the RPC server.</description>
        <name>yarn.timeline-service.address</name>
        <value>tmaster:10201</value>
    </property>
    <property>
        <description>The http address of the Timeline service web application.</description>
        <name>yarn.timeline-service.webapp.address</name>
        <value>tmaster:8188</value>
    </property>
    <property>
        <description>The https address of the Timeline service web application.</description>
        <name>yarn.timeline-service.webapp.https.address</name>
        <value>tmaster:2191</value>
    </property>
    <property>
        <name>yarn.timeline-service.handler-thread-count</name>
        <value>24</value>
    </property>

启动timeline
    yarn-daemon.sh start timelineserver 

3. 安装TEZ UI
    #在webapps下创建tez-ui目录
    mkdir /usr/local/apache/apache-tomcat-8.5.31/webapps/tez-ui

    #进入文件
    cd  /usr/local/apache/apache-tomcat-8.5.31/webapps/tez-ui

    #解压war包
    unzip tez-ui-0.9.0.war

    #编辑配置文件
    config/configs.env
        timeline:   //timeline server
        rm:    //resource manager web proxy address

    # 启动tomcat
    catalina.sh start
    # 访问  tomcat:8080/tez-ui
```
