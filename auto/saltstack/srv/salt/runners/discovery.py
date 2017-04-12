# -*- coding: utf-8 -*-
import salt.client
import salt.config
from datetime import datetime
import MySQLdb
import uuid
import time

opts = salt.config.master_config('/etc/salt/master')
host = opts.get('mysql.host', '127.0.0.1')
port = opts.get('mysql.port', 3306)
user = opts.get('mysql.user')
passwd = opts.get('mysql.pass')
db = opts.get('mysql.db')

def MB2GB(mb):
    rt = mb/1000
    if rt > 0:
        return  str(rt) + 'G'
    else:
        return str(mb) + 'M'

def register(mid):
    client = salt.client.LocalClient(__opts__['conf_file'])
    time.sleep(60) # wait for minion start
    data = client.cmd(mid, 'grains.items', timeout=10)
    data = data.get(mid)
    # 有无通过syndic代理
    if data.get('return'):
        data = data['return']
    # 必须配置fqdn 
    #/etc/hosts
    #<hostname>  <ip>            
    ip4  = data.get("fqdn_ip4")
    ip4_interfaces = data.get("ip4_interfaces")
    inf = None
    for k, v in ip4_interfaces.items():
        if v == ip4:
            inf = k
            break
    hwaddr_interfaces = data.get("hwaddr_interfaces")
    mac = hwaddr_interfaces.get(inf)
    # fqdn_ip4 to eth to mac
    cpu = data.get("num_cpus")
    memory = MB2GB(int(data.get("mem_total")))
    system = data.get("os")
    system_cpuarch = data.get("osarch")
    system_version = data.get("osrelease")
    #todo:
    # 1. 硬盘大小
    conn = MySQLdb.connect(host=host, user=user, passwd=passwd, db=db, port=port)
    cursor = conn.cursor()
    # check host existence
    sql = '''select 1 from `assets_host` where node_name="%s"'''
    cursor.execute(sql % str(mid))
    rt = cursor.fetchone()
    if rt:
        print 'Host alread registered'
        return True
    # register host
    sql = '''INSERT INTO `assets_host`
        (`uuid`,`node_name`, `eth1`,`mac`, `cpu`, `memory`, `system`, `system_cpuarch`, `system_version`, `type`, `create_time`, `status`, `idle`)
        VALUES ("%s", "%s", "%s", "%s", "%s","%s", "%s", "%s", "%s", "%s", "%s", "%s", %s)'''
    try:
        cursor.execute(sql % (str(uuid.uuid1()).replace('-',''), str(mid), str(ip4[0]), str(mac),str(cpu), str(memory), str(system), str(system_cpuarch), str(system_version), str(1), datetime.now().strftime('%Y-%m-%d %H:%M:%S'), str(1), True))
        conn.commit()
    except Exception as e:
        print e
    finally:
        cursor.close()
        conn.close()
    return True

