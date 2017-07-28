## intall and start
```
https://hub.docker.com/r/sath89/oracle-xe-11g/

docker pull sath89/oracle-xe-11g

docker run -d -p 18080:8080 -p 11521:1521 -v ~/oracle_data:/u01/app/oracle\
-e processes=100 \
-e sessions=100 \
-e transactions=100 \
sath89/oracle-xe-11g
```
## connect by this setting
```
hostname: localhost
port: 11521
sid: xe
username: system
password: oracle

Password for SYS & SYSTEM: oracle

web management 
    http://localhost:18080/apex
    workspace: INTERNAL
    user: ADMIN
    password: oracle
```
