## linked container
## expose docker api to network
```
dockerd -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock
```
## oss storage
```
docker-registry + oss + nginx + ssl
docker client
```
## set docker storage root
```
DOCKER_OPTS="-g /mnt/DATA/docker"
```
## set contianer dns 
```
DOCKER_OPTS="--dns 8.8.8.8"
```
## do not use docker-proxy to do DNAT
```
DOCKER_OPTS="--userland-proxy=false"
```

## pulling from a different registry
```
docker client使用https协议与registry进行通信
docker pull myregistry.local:5000/testing/test-image

```
  
## image digest
```
docker pull [OPTIONS] NAME[:TAG|@DIGEST]
```

## docker-proxy
```
a process to do DNAT in host
```

## expose a range of ports
```
docker run -p 7000-8000:7000-8000
```

## docker port mapping set host ip
```
docker run --bind 127.0.0.1
```

## can't run top in container
```
issue: TERM environment variable not set.
export TERM=xterm
```


##  docker log output
```
docker logs -f <cid>
docker logs --tail=200 <cid>
```


## show image entrypoint definition
```
docker inspect -f <entrypoint> <id>
```
  
## docker restart policy
```
restart policy
    no: default
    on-failure: restart a container if the exit code is error but 
                not if the exit code is success. can specify a 
                maximum number of times docker will automatically
                restart the container
                --restart on-failure:5
    unless-stopped: if the container war running before the reboot
                the container would be restarted once the system 
                restarted
    always: docker will restart the container everytime it exists

```

## docker port mapping http response very slow at first time
## Conclusion
1. stop a container will keep environment variable, all system setting


## rename image 
```
docker tag  origin:tag  target:tag
docker rmi origin:tag
```

## docker-compose
```
docker-compose -f <file.yml> up  &
docker-compose -f <file.yml> down
```

## docker pull proxy
```
/etc/systemd/system/docker.service

[service]
Environment="HTTP_PROXY=http://192.168.33.125:8888/" "NO_PROXY=localhost,127.0.0.1,registry.local.com"
Environment="HTTPS_PROXY=https://192.168.33.125:8888/" "NO_PROXY=localhost,127.0.0.1,registry.local.com"

systemctl daemon-reload
systemctl restart docker
```

