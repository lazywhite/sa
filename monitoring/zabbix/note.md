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
