from pyzabbix import ZabbixAPI

zapi = ZabbixAPI('http://192.168.33.77/zabbix')
zapi.login('admin', 'zabbix')
print zapi.id, zapi.auth
