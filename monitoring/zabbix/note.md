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
    "$" 无需escape

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
## zabbix代理模式配置问题
```
zabbix proxy日志显示host not found
    确保zabbix数据库中hosts表host, name 字段名称相同并且跟agent的Hostname一致


zabbix-proxy如果是被动模式, zabbix-master添加如下配置
    StartProxyPollers=5
    ProxyConfigFrequency=30
    ProxyDataFrequency=1

zabbix agent Hostname可以直接写ip
```
## 实体唯一性原则
```
1. item: key
2. trigger: name and expression
3. graph: name and items
4. application: 名称
```
## Tips
```
zabbix-server的agent默认是禁用状态, 需要手动启用
修改web字体后, 无需重启httpd

如果需要ipmi监控, 必须在master加入如下配置, 默认是0不开启
StartPollers=5
添加主机, ipmi接口, ipmi

如果需要自动发现, 必须加入如下配置
StartDiscoverers=10


IPMI checks will not work with the standard OpenIPMI library from Debian/Ubuntu package. 
To fix, recompile OpenIPMI library with OpenSSL enabled as discussed in ZBX-6139.


由不同代理程序监控的主机, 如果跟其他主机的主机名重复, 会导致分组混乱

agent Hostname写IP, agent不可用问题

HP380系列获取IPMI Power为2watt的问题, 是因为power sensor不标准导致, zabbix bug

字符串型的监控项没有历史趋势

执行dmidecode需要root权限, zabbix-agent需要AllowRooT=1

python-dmidecode
yum -y update dmidecode

item key的参数, 不能包含空格, 需要用其他字符替换

新添加userparameter配置文件, 需要重启agent

zabbix主机, 一种agent可以有多个interface, 主要的interface main=1
hosts status=1 表示禁用

can't send list of active check to [], 有可能是因为没有链接linux os模板

system.cpu.discovery
system.cpu.num[online]

ids表保存zabbix自己维护的主键nextid
```

