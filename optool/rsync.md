## Example
```
rsync -avrz --delete --exclude=.git -e 'ssh -p 2133' build/  root@192.168.21.33:/mnt/nexttao_www/build/

目录后面必须加/
    rsync -avrz --delete root@192.168.1.12:/root/vue-ssr/  vue-ssr/
```


## Parameter
```
    --delete
    -a: archive
    -v: verbose
    -z: compress
    -q: quiet
    --exclude=PATTERN: exclude files matching PATTERN
```

## Behind Squid
```
squid.conf
    acl SSL_ports port 443 563 873  # 873 - for rsync
    acl Safe_ports port 873         # for rsync
    acl allowed_hosts src 195.208.220.197/255.255.255.255 # trusted host
    http_port 8888

export RSYNC_PROXY=192.168.33.125:8888 
rsync -avz  rsync://192.168.33.125/centos/ /mirrors/centos/
```
