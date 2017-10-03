## State
state.apply
## Remote Execution
```
salt '<target>' <function> [arguments...]
```
## Fileserver backend
可以配置多个file backend, 默认是roots, 按照backend定义顺序搜索, 返回第一个匹配到的   
```
fileserver_backend:
    - roots
    - git

file_roots:
    base:
        - /srv/salt/prod

gitfs_remotes:
    - https://domain/repos/first.git
```

## Render
负责将sls配置文件解析成python数据类型供salt使用  
目前支持Jinja + YAML, Mako + YAML, Wempy + YAML, Jinja + json, Mako + json and Wempy + json.  
可以自定义render实现HTML, XML等文件格式的解析  

## Events
```
beacons: 监测salt之外其他进程的状态, 并产生相应的事件
    文件更改
    系统负载
    特定服务状态
    用户登录
    网络状态
```
## Reactor
根据相应的事件, 触发相应的动作

## Orchestration
通过runner来进行多个minion之间的联动  

## Salt SSH(Roster)
无需安装salt-minion, 直接通过ssh传送thin-salt-minion到目标机器/tmp, 执行完毕后  
可以清空临时文件(可选)  
   
```
/etc/salt/roster
    web1:
        host:
        user:
        password:
```
## Salt Cloud
提供云服务宿主机的交互, 虚拟机的创建过程可配置, 启动的虚拟机可自动连接至salt-master
```
/etc/salt/cloud
/etc/salt/cloud.providers.d/*.conf
/etc/salt/cloud.profiles.d/*.conf
```

## Salt Proxy Minion
为无法运行salt-minion的设备提供代理服务  

## Salt Mine
```
从minion收集任意方面的数据, 存储在master端, 供其他minion使用
"mine data" is more up-to-date than "grain data"
当一个minion需要其他minion的数据时, 使用mine比grains更快速

/etc/salt/minion.conf
    mine_function
    mine_interval

salt['mine.get']('roles:web', 'network.ip_addrs', expr_form='grain') 
```

## Salt Virt  

## Salt Runner
runner是一个在master端执行的模块函数, 封装了一系列的操作, 类似于bash中ls|grep|awk


## 异步
```
salt --async '*' test.ping # return a jid
salt-run jobs.lookup_jid 20161117163153353501 # check result on minion 
```

## Returner
```
默认minion执行的结果会发送回master, 通过配置returner, 可以将结果发送到外部存储以供分析处理

自定义returner
    1. 定义returner: returner就是包含了returner()函数定义的一个模块, 名称默认是模块名, 可以用__virtualname__覆盖, 保存在/srv/salt/_returners
    2. 同步至minion
    3. salt "*" cmd.run "ls" --return mysql[,redis][,mongo] #可以同时使用多个returner

分类
    mysql
    redis_return
    kafka_return
```

## schedule
```
/srv/pillar/top.sls
base:
    "*":
        - schedule

/srv/pillar/schedule.sls
schedule:
    test-job:
        function: cmd.run
        seconds: 10
        args:
            - "date >> /tmp/date.log" 

salt "*" saltutil.refresh_pillar
salt "*" pillar.get schedule

```
https://docs.saltstack.com/en/latest/topics/jobs/schedule.html

## Topic
1. salt-run永远在master执行
2. salt-call永远在minion执行
3. salt-syndic not respond to test.ping  
4. salt-master可以直接控制内网中的minion
5. use pgrep or pkill, not to use too many pipe  
6. salt-master需要监听4505, 4506, salt-minion无需监听端口

