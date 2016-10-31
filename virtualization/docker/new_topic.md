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
