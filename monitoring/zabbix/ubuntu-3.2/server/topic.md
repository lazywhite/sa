
##  zabbix-server cant start
cannot allocate shared memory of size 912680551: [22] Invalid argument
cannot allocate shared memory for configuration cache

```
sysctl -w kernel.shmmax = 33554432
sysctl -w kernel.shmmax=33554432
sysctl -w kernel.shmall=2097152

zabbix_server.conf
    CacheSize=20M  # enlarge this option
```


