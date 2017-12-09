## Installation
1. download schemaSpy.jar from official site
2. download jdbc-driver of target database 
3. brew install graphviz

```
java -jar schemaSpy_5.0.0.jar -t pgsql -dp pg-driver.jar -host localhost -db cds -s public -u white -o cds_output

 java -jar schemaSpy_5.0.0.jar -t mysql -dp mysql-connector-java-5.1.42.jar -host 192.168.33.125 -db zabbix -u zbx_user -o zabbix_output -p pass
```
