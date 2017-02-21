docker pull microsoft/mssql-server-linux


sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=1q2w3eQQ' -p 1433:1433 -v <host directory>:/var/opt/mssql -d microsoft/mssql-server-linux
