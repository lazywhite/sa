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

## how to configure ganglia rrds storage path
/etc/ganglia/gmeta.conf:
    rrd_rootdir "/wdzj/rrds"
/usr/share/ganglia/conf_default.php: 
    $conf['rrds'] = "/wdzj/rrds";
