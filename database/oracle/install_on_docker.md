## intall and start
```
docker pull wnameless/oracle-xe-11g
docker run -d -p 49160:22 -p 49161:1521 -e ORACLE_ALLOW_REMOTE=true wnameless/oracle-xe-11g
```
## connect by this setting
```
hostname: localhost
port: 49161
sid: xe
username: system
password: oracle
Password for SYS & SYSTEM

oracle
Login by SSH

ssh root@localhost -p 49160
password: admin
```
