## 准备工作
```
https://cwiki.apache.org/confluence/display/AMBARI/Installation+Guide+for+Ambari+2.7.4
获取ambari rpm包， 可自己编译或下载, 并建立ambari repo
下载hdp，hdp-util 包，并建立repo
添加centos-7 及epel包
每台机均安装jdk8至/usr/local/jdk8
确保每台机均有fqdn，并可互相解析
确保时间同步
设置ulimit，selinux，iptables

架构
    node1(ambari-server)
    node2(ambari-agent)

```
## 安装

```
1. node1
    yum -y install ambari-server
    sudo ambari-server setup(需要root权限)
        执行用户
        jvm路径

    sudo ambari-server start
    http://node1:8080  (admin/admin)

2. 所有节点
    yum -y install ambari-agent
    /etc/ambari-agent/conf/ambari-agent.conf
        hostname=node1
    sudo ambari-agent start

3. 进入页面进行部署
    不选择配置ssh公钥方式， 自己注册主机(需要自己安装agent)
```
