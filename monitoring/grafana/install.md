```
wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-4.5.1-1.x86_64.rpm

yum localinstall grafana-4.5.1-1.x86_64.rpm
grafana-cli plugins list-remote
grafana-cli plugins install alexanderzobnin-zabbix-app
systemctl start grafana-server

http://localhost:3000    admin/admin

enable zabbix plugin
Datasource --> Add (type zabbix)
```
