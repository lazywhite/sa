```
# CentOS-7 only

## install mssql-server
curl https://packages.microsoft.com/config/rhel/7/mssql-server.repo > /etc/yum.repos.d/mssql-server.repo
yum install -y mssql-server
/opt/mssql/bin/sqlservr-setup
systemctl status mssql-server


## install mssql-clients
curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/msprod.repo
yum remove unixODBC-utf16 unixODBC-utf16-devel
yum install mssql-tools unixODBC-devel
/etc/hosts
    <hostname> <eth0_ip>

systemctl restart mssql-server


## connect by sqlcmd
sqlcmd  -H localhost -U sa -P 1q2w3eQQ

```

## install by docker
```
docker pull microsoft/mssql-server-linux

docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=1q2w3eQQ' -p 1433:1433 -v <host directory>:/var/opt/mssql -d microsoft/mssql-server-linux
```
