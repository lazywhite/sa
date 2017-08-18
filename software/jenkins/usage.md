## add slave node
```
1. 远程工作目录   /home/jenkins
2. 用法  只允许运行绑定到这台机器的job
3. 启动方法 launch agent via SSH   <username>/<password>
4. Node Properties
    "JAVA_HOME" "/path/to/jdk_home"
5. Tool Locations
    Maven  /home/tool/maven-3.3.9
```

## start jenkins
```
nohup java -jar /home/jenkins/jenkins.war --httpPort=9090 --prefix=/jenkins > /home/jenkins/jenkins.log 2>&1 &

```

## Topic
1. global variable definition
2. run job on specified node
3. multi-job plugin
4. run job in sequence
