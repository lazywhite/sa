check_ganglia
    ganglia_port 8651
    gmetad  trusted_hosts 127.0.0.1 other


ganglia + nagios
    数据过期时间dmax
    check_ganglia.py
    架构
    单播
    storage backend


monitoring with ganglia 
    ganglia sflow



/usr/lib64/ganglia/python_modules : gmond need
/usr/share/ganglia/graph.d   : gmetad need

## ganglia rrds storage path
/etc/ganglia/gmeta.conf:
    rrd_rootdir "/wdzj/rrds"



<?php

#
# /etc/ganglia/conf.php
#
# You can use this file to override default settings.
#
# For a list of available options, see /usr/share/ganglia/conf_default.php
#

$conf['auth_system'] = 'enabled';
$acl = GangliaAcl::getInstance();
$acl->addRole( 'ganglia', GangliaAcl::ADMIN );

$conf['rrds'] = "/wdzj/rrds";
?>

## topic
注意防火墙一定要开放端口


## create admin user for ganglia web
Alias /ganglia /usr/share/ganglia

<Location /ganglia>
  Order allow,deny
  Allow from all
  # Allow from .example.com
</Location>


SetEnv ganglia_secret secret

<Files "login.php">
  AuthType Basic
  AuthName "Ganglia Access"
  AuthUserFile /etc/httpd/conf.d/auth
  Require valid-user
</Files>


htpasswd -c -b  /etc/httpd/conf.d/auth ganglia <ganglia password> 


## create live_dashboard
create view; add graph to view; add view to live dashboard
