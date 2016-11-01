## set docker port binding of host ip addr

docker run --ip -p <host_port>:<inner_port>


## set docker storage root
-g /mnt/DATA/docker


## set dockerd variables 
docker daemon

## set default ip when binding container port
--ip

## pulling from a different registry
docker use "https://" protocol to communicate with a registry
```
docker pull myregistry.local:5000/testing/test-image

```

## image digest
docker pull [OPTIONS] NAME[:TAG|@DIGEST]

## docker-proxy


## expose a range of ports
docker run -p 7000-8000:7000-8000



## can't run top in container
issue: TERM environment variable not set.
export TERM=xterm


## follow docker log output

docker logs -f <cid>
docker logs --tail=200 <cid>


## show image entrypoint definition
docker inspect -f <entrypoint> <id>
## docker restart policy
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


## Topic
1. stop a container will keep environment variable, all system setting
