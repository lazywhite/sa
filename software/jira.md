## Installation
1. ./atlassian-jira-software-7.0.10-jira-7.0.10-x64.bin
2. cp mysql-connector-java-5.1.39-bin.jar /opt/atlassian/jira/lib
3. create database, user for jira in mysql 
4. service jira start
5. follow installation guild on html page, get trial token from officail
6. service jira stop
7. cp atlassian-extras-3.1.2.jar /opt/atlassian/jira/atlassian-jira/WEB-INF/lib
8. service jira start
9. upload and install jira-core-language-pack-zh_CN-7.0.10-v2r635-2016-01-27.jar plugin  

  
## Configure SMTP
```
名称: exmail
描述: <blank>
发信地址: bot@demo.com
邮件前缀: [JIRA]

SMTP服务器
    协议: SECURE_SMTP
    服务器名称: smtp.exmail.qq.com
    SMTP端口: 465
    超时: 5000
    TLS: true
    账号: bot@demo.com
    密码: <password>
```
  
## LDAP integration
```
用户目录-->添加<LDAP>

服务器设置
    名称: LDAP
    目录类型: Generic Posix/RFC2307 Directory(Read-Only)
    主机名: <ip>
    端口: 389  <ssl no>
    账号: cn=manager,dc=local,dc=com
    密码: <password>
LDAP模式
    基础DN: dc=local,dc=com

LDAP权限
    读写
高级设置
    简单DN匹配: true
    同步间隔: 10 <分钟>
设置用户模式
    用户对象类: inetorgperson
    用户对象过滤: (objectclass=inetorgperson)
    用户名属性: cn
    用户名RDN属性: cn
    用户名字属性: givenName
    用户姓氏属性: sn
    用户显示名属性: cn
    用户邮箱: mail
    用户密码属性: userPassword
    用户密码加密: SSHA
    用户唯一ID属性: uid
用户组模板设置
    用户组对象类: posixGroup
    组对象过滤: (objectclass=posixGroup)
    组名属性: cn
    组描述属性: description
设置成员模式
    组成员属性: memberUid
    成员属性: memberOf
```


## 导入外部系统
系统配置-->导入与导出 --> RedMine
version
    import plugin
    redmine
