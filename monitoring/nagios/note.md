nagios
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



nagios   
>    nrpe: nagios remote plugin executeor  
>    nsca: nagios service check acceptor  
>    nagios-plugin  


报警延迟是由于host or service状态不稳定，nagios称之为flapping state  
htpasswd -c -b  /etc/nagios/passwd nagiosadmin admin

