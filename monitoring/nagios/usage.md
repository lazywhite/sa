## Keyword
```
hostgroup
    members(host)

host
    host_name

servicegroup
    members(<host>,<service>)

service
    host_name <host>
    check_command <command>!ag1!ag2
    contact_groups  <contact_group>,<contact_group>

contactgroup
    members

contact
    email

command
    command_name
    command_line
        USER1 

nsca: nagios service check acceptor  
nrpe: nagios remote plugin executeor  
```

## 配置文件
```
/etc/nagios
    cgi.cfg
    nagios.cfg    # 主配文件
    nrpe.cfg      # client nrpe主配文件
    passwd        # httpd 登陆认证文件

    objects:
        commands.cfg  # 命令配置
        contacts.cfg  # 联系人配置
        localhost.cfg # linux机器配置样例
        printer.cfg   # 打印机配置
        switch.cfg    # 交换机配置
        templates.cfg # 主机组,主机模板
        timeperiods.cfg  # 时间段配置
        windows.cfg   # windows机器配置样例

    private:
        resource.cfg  # 全局变量
```

## 架构
```
server
    web-frontend
    nagios core engine
    plugins
        nrpe
        snmp

client
    nrpe
    snmp
```



## 2.1 添加主机
```
/etc/nagios/objects/servers/app1.cfg


define host {

    use                     linux-server            ; Name of host template to use
    host_name               app1
    alias                   app1.local.com
    address                 192.168.1.223
}



define hostgroup {

    hostgroup_name          app-servers           ; The name of the hostgroup
    alias                   Application Servers           ; Long name of the group
    members                 app1               ; Comma separated list of hosts that belong to this group
}


define service {

    use                     local-service           ; Name of service template to use
    host_name               app1
    service_description     PING
    check_command           check_ping!100.0,20%!500.0,60%
}

```

## 2.2 添加扩展命令
```
1. 客户端
/etc/nrpe/nrpe.cfg # 添加配置需要重启nrpe
    command[check_odd]=/usr/lib64/nagios/plugins/check_odd $ARG1$ $ARG2$


# 退出码决定是否报警
/usr/lib64/nagios/plugins/check_odd
    #!/bin/bash
    a=10
    ((b=a%2))

    if [[ $b -eq 0 ]];then
    echo "10 is even"
    exit 0
    else
    echo "10 is odd"
    exit 0
    fi

systemctl restart nrpe

2. server端
/etc/nagios/objects/servers/app1.cfg

define command {

    command_name    check_host_odd
    command_line    $USER1$/check_nrpe -H $HOSTADDRESS$ -u -t 5 -c check_odd
}

define service {

    use                     generic-service           ; Name of service template to use
    host_name               app1
    service_description     check_host_odd
    check_command           check_host_odd
}
  
systemctl restart nagios

```
## 2.3 添加service group
```
/etc/nagios/nagios.cfg
    cfg_file=/etc/nagios/objects/servicegroup.cfg

/etc/nagios/objects/servicegroup.cfg
    define servicegroup {
        servicegroup_name       HostAlive Service
        alias                   host alive
        members                 app1,PING,localhost,PING    # 格式为   "主机1,service_description,主机2,service_description..."
    }

```


## 2.4 添加短信报警

```
define service {
    use  generic-service
}

define service {
    name             generic-service  
    check_period     24x7   # timeperiod.cfg
    contact_groups   admin  # default
}

define contactgroup {
    contactgroup_name       admins
    members                 nagiosadmin  # default
}

define contact {
    use                     generic-contact
    contact_name            nagiosadmin  
    email                   nagios@localhost
    address1                13020107865            # 扩充属性addressx 可以使用  $CONTACTADDRESSx$ 获取
}

define contact {
    name                    generic-contact
    email                   nagios@localhost
    service_notification_commands   notify-service-by-sms ; send service notifications via email
    host_notification_commands      notify-host-by-sms    ; send host notifications via email
    register                        0                       ; DON'T REGISTER THIS DEFINITION - ITS NOT A REAL CONTACT, JUST A TEMPLATE!
}


define command {
    command_name    notify-host-by-sms
    command_line    send_sms.py  $CONTACTADDRESS1$  
}



define command {
    command_name    notify-service-by-sms
    command_line    send_sms.py  $CONTACTADDRESS1$      
}



```
