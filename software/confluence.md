# Installation
1. ./atlassian-confluence-5.10.0-x64.bin
2. mv lib/mysql-connector-java-5.1.39-bin.jar   <Confluence_DIR>/lib/
3. crate database, user for confluence and start service 
4. configure through webpage and get trial token from official site
5. service confluence stop
6. cp atlassian-extras-decoder-v2-3.2.jar  <Confluence_DIR>/confluence/WEB-INF/lib
7. service confluence start
8. upload  Confluence-5.10.0-language-pack-zh_CN.jar plugin to add zh_CN support


# Issue
## Logpath
    /var/atlassian/application-data/confluence/logs

## LDAP integretion
```
服务器设置
	名称: LDAP服务器
	目录类型: Generic Posix/RFC2307 Directory<Read-Only>
	主机名: <ip>
	端口: 389  <ssl false>
	账号: cn=manager,dc=local,dc=com
	密码: <password>

LDAP模式
	基础DN: dc=local,dc=com
	
LDAP权限
	只读

高级设置
	简单DN匹配
	同步间隔: 10<分钟>
	读取超时: 120
	搜索超时: 60
	连接时限: 10

设置用户模式
	用户对象类: inetorgperson
	用户对象过滤: (objectclass=inetorgperson)
	用户名属性: uid
	用户名RDN属性: <blank>
	用户名字属性: givenName
	用户姓氏属性: sn
	用户显示名属性: displayName
	用户邮箱: mail
	用户密码属性: userPassword
	用户密码加密: SSHA
	用户唯一的ID属性: entryUUID

用户组模板设置
	用户组对象类: posixGroup
	组对象过滤: (objectclass=posixGroup)
	组名属性: cn
	组描述属性: description

设置成员模式
	组成员属性: memberUid
	成员属性: memberOf
 
```

## Can't create group
disable LDAP then create group
      
## SMTP server not work
 

1. cd /opt/atlassion/confluence
2. mv confluence/WEB-INF/lib/mail-1.4.5.jar  ./lib/
3. stop confluence
4. modify server.xml (don't use SSL)
5. start confluence  

```
## configure mail server by Dashboard

SMTP服务器详情
	名称: SMTP
	发信地址: bot@test.com
	发件人显示名: Confluence
	主题前缀: [Confluence]
JNDI位置
	java:comp/env/mail/QqSMTPServer
	
```
  
```
# /opt/atlassian/confluence/conf/server.xml

<Server port="8000" shutdown="SHUTDOWN" debug="0">
    <Service name="Tomcat-Standalone">
        <Connector port="8095" connectionTimeout="20000" redirectPort="8443"
                maxThreads="48" minSpareThreads="10"
                enableLookups="false" acceptCount="10" debug="0" URIEncoding="UTF-8"
                protocol="org.apache.coyote.http11.Http11NioProtocol" />

        <Engine name="Standalone" defaultHost="localhost" debug="0">

            <Host name="localhost" debug="0" appBase="webapps" unpackWARs="true" autoDeploy="false">

                <Context path="" docBase="../confluence" debug="0" reloadable="false" useHttpOnly="true">
                    <!-- Logger is deprecated in Tomcat 5.5. Logging configuration for Confluence is specified in confluence/WEB-INF/classes/log4j.properties -->
                    <Manager pathname="" />
                    <Valve className="org.apache.catalina.valves.StuckThreadDetectionValve" threshold="60" />
                    <Resource name="mail/QqSMTPServer"
                        auth="Container"
                        type="javax.mail.Session"
                        mail.smtp.host="smtp.exmail.qq.com"
                        mail.smtp.port="25"
                        mail.smtp.auth="true"
                        mail.smtp.user=""
                        password=""
                        mail.smtp.starttls.enable="false"
                        mail.smtp.socketFactory.class="javax.net.ssl.SSLSocketFactory" />
                </Context>
            </Host>

        </Engine>

    </Service>
</Server>
```



