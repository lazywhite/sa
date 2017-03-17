宏
    模板宏
    主机宏
    全局宏

zabbix
    host group
        host
            item
                trigger
                    event
                        action
                            media
                                user

template
    enclosed
    link

auto discovery

monitor
    snmp



#监控系统
    zabbix
        1. zabbix api
            协议: jsonRpc{method, params}
            用途:
                获取历史数据
                CRUD配置

        2. 调用zabbix生成图片
            1. 获取web cookie
            2. chart2.php?graphid=xxx
            

        3.. 应用收集及自动添加监控
            需要自己实现

        4. template system
            nest
            link, auto_link

        5. auto discovery
            check_type
                zabbix_agent, network range
                snmp  OID

        6. macro
            host
            template
            global


# userparameter
UserParameter=<key>,<command>
<key>=<String[parameter01,parameter02],command $1... 

<commad>: escape '$' awk '{print $$4}'


## user defined macro
{$MACRONAME} 

## command line tool
```
zabbix_sender -z zabbix -s "Linux DB3" -k db.connections -o 43
zabbix_get -s 127.0.0.1 -p 10050 -I 127.0.0.1 -k "system.hostname"
```

## web scenario 
```
配置-->主机-->web监控-->添加--> 客户端（chrome) --> 步骤 --> 200 or string
触发器 {10.30.95.34:web.test.fail[web1].avg(#3)}=1
```
