## installation
```
curl -o jenkins.war http://mirrors.jenkins-ci.org/war/latest/jenkins.war
java -jar jenkins.war --httpPort=9000 > jenkins.log &
```

## check jenkins version 
unzip -c jenkins.war   META-INF/MANIFEST.MF|grep 'Jenkins-Version'

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


## 安装插件
```
系统设置-->管理插件-->高级
    配置代理
    可选插件-->搜索-->直接安装
    勾选"插件完成时重启jenkins"
```

## Topic
```
job构建任务一直是pending状态
    系统管理-->管理节点-->master-->执行者数量 > 0

gitlab插件使用
    https://github.com/jenkinsci/gitlab-plugin
    1. 关闭认证
        系统管理--> 系统设置--> gitlab--> 关闭 	"Enable authentication for '/project' end-point"
    2. repo配置hook   http://jenkins:port/project/job-id
              
    3. job使用deploy key拉取代码

    4. 有n个分支有更新, 会触发n次webhook, 每个$GIT_BRANCH一次
```


## smtp 
501 mail from address must be same as authorization user

```
以下两项应该一样
Jenkins Location
    system admin email address: noreply@xxx.com

SMTP
    user: noreply@xxx.com    
```

## 添加maven tool
```
System Config --> Global Tool Configuration --> Maven
    add maven --> MAVEN_HOME=/usr/share/maven
```
