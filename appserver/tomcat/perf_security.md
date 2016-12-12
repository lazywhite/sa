#  一、tomcat性能调优
## 1.1 JVM调优
###1.1.1 调整JVM内存配置
前提: 4核32G服务器  

```
bin/catalina.sh
    JAVA_OPTS="-Djava.awt.headless=true -Dfile.encoding=UTF-8
            -server -Xms=16384m -Xmx=16384m -XX:+DisableExplicitGC
            -Xmn=8048m -XX:SurvivorRatio=10"


-verbose:class: 输出jvm载入类的相关信息
-verbose:gc : 输出每次gc的相关情况
-verbose:jni : 输出native方法调用的相关情况
-XX:NewSize: 新生代初始内存
-XX:MaxNewSize: 新生代最大内存
-XX:PermSize: 方法区初始内存, jdk8无需设置
-XX:MaxPermSize: 方法区最大内存， jdk8无需设置
-XX:NewRatio: 新生代与老年代内存容量比值
-XX:ReservedCodeCacheSize: 保留代码占用的内存容量
-XX:ThreadStackSize: 线程栈大小
-XX:LargePageSizeInBytes: 用于java堆得大页面尺寸
-XX:SurvivorRatio: E:S0:S1, 设置为10， 提高E区的容纳量
-Xms: JVM初始化堆内存, 一般为总内存的一半
-Xmx: JVM最大可使用堆内存, 与Xms保持一致， 防止内存抖动
-Xmn: 新生代内存最大值， 包括E区和S0, S1区， 一般为Xms的一半
-server: 服务器模式， 新生代并行GC, 老生代、持久代并发GC
-Xss: 每个线程的栈内存
-Xrs: 减少jvm对OS signals的使用
-Xprof: 跟踪正在运行的程序， 并将数据打印在标准输出
-Xnoclassgc: 关闭针对class的gc功能, 可能会导致OutOfMomeoryError
-Xincgc: 开启增量gc， 有助于减少长时间gc导致的应用程序停顿
-Xloggc:file: 将每次gc时间的相关情况记录到文件中
-XX:+DisableExplicitGC: 关闭显式GC
-XX:+UseParNewGC: 对新生代采用多线程并行回收

```
## 1.2 tomcat容器调优
### 1.2.1 解决JRE内存泄露
```
conf/server.xml
    Listener 
        className="org.apache.catalina.core.JreMemoryLeakPreventionListener"
```
### 1.2.2 HTTP最大连接数量
```
conf/server.xml
     Connector
         maxThreads="2048"
```
### 1.2.3 MIME压缩
```
文件超过500bytes会被自动压缩
conf/server.xml
    Connector
        compression="500"
        compressableMimeType="text/html,text/xml,text/plain,application/octet-stream"
```
### 1.2.4 数据库连接性能优化
```
使用第三方数据库连接池
    druid
        maxIdle
        maxActive
        maxWait
```
### 1.2.5 防止应用相互影响

不使用虚拟主机， 采用多tomcat实例


## 二、安全配置
### 2.1 禁用8005端口 
```<Server port="-1" shutdown="SHUTDOWN">```
### 2.2 初始化
删除webapps目录下所有内容 

### 2.3 tomcat用户权限
```
注释掉tomcat用户所有权限

# cat conf/tomcat-users.xml
<?xml version='1.0' encoding='utf-8'?>
<tomcat-users>
</tomcat-users>
```
### 2.4 隐藏tomcat版本信息
```
conf/server.xml
   Connector
       server="Neo App Srv 1.0"
 
```
### 2.5 隐藏404页面tomcat版本信息
```
lib/org/apache/catalina/util/ServerInfo.properties
    server.info=Apache
    server.number=
    server.built=
```
### 2.6 关闭热部署
```
conf/server.xml
	Host
		unpackWARs="false" 
		autoDeploy="false"  
		reloadable="false" 
```
