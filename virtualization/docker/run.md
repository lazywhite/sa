## set environment variable
```
docker run -e "key=value" [-e "key2=value1"] --entrypoint <container_file_path> <image> 

```

```
docker run
    --rm:  remove the container after it exit
    -h: container hostname
    -t: allocate a pseudo-TTY
    -i: interactive mode
    --env-file /path/to/env-file: get environment from file
    --ip: container ip address
    -l/--label: set metadata of container
    --link <value>: add link to another container
    --mac-address <mac>: container mac address
    --oom-kill-disable: disable oom-killer
    --pid <pid>: pid namespace to use
    --privileged: give extended privilege to this container
    -p <host_port:container_port>: publish host port to this container
    -P : publish all exposed ports to random ports of host
    --restart: set restart policy for this container
    --sig-proxy: proxy received signal to this container, default true
    --storage-opt: storage driver option for this container
    -v <host_dir>:<container_path>[:options]
```
