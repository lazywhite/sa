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

history table: store each single point
trend: store average information on hourly basis
template
    enclosed
    link

auto discovery
auto link template

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
                管理-->一般-->macro


## userparameter
不带参数的
    UserParameter=<key>,<command>
    zabbix_get -s 127.0.0.1 -p 10050 -I 127.0.0.1 -k "system.hostname"

带参数的
    UserParameter=key[*],<command> $1 [$2 ...]
    zabbix_get -s 127.0.0.1 -p 10050 -I 127.0.0.1 -k total_process[DIA]

    <commad>: escape '$' awk '{print $$4}'


## call macro
user defined macro: {$MACRONAME} 
global macro: {TRIGGER.NAME}


## command line tool
```
zabbix_sender -z zabbix -s "Linux DB3" -k db.connections -o 43

```

## web scenario 
```
配置-->主机-->web监控-->添加--> 客户端（chrome) --> 步骤 --> 200 or string
触发器 {10.30.95.34:web.test.fail[web1].avg(#3)}=1
```

## zabbix 队列积压问题
```
管理--队列
    overview
    overview by proxy
    detail
```
