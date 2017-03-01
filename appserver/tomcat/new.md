```
CATALINA_BASE
    tomcat运行在multi-instance环境下才需要
    tomcat_inst1
        conf logs temp webapps work shared 
CATALINA_HOME
    bin
    tomcat_inst1
    tomcat_inst2
```

## Topic
### set jvm memory usage
```
catalina.sh
    export CATALINA_OPTS="$CATALINA_OPTS -Xms512m"
    export CATALINA_OPTS="$CATALINA_OPTS -Xmx8192m"
    export CATALINA_OPTS="$CATALINA_OPTS -XX:MaxPermSize=256m"

```
### set http connection bind ip
```
<Connector 
    port="8080" 
    protocol="HTTP/1.1" 
    address="127.0.0.1"
    connectionTimeout="20000" 
    redirectPort="8443" 
  />
```
