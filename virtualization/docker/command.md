## docker-proxy
## docker swarm
docker node
docker service
docker stack

## sub command
```
docker volume:  manage docker volumes 
    ls 
    inspect
    rm
    create
docker update: update configuration of one or more containers
    -m : memory limit
    --kernel-memory: kernel memory limit
    --memory-reservation: memory soft limit

docker events: get real time events from the server
docker build: build an image from a docker file
docker cp: copy files/folders between a container and the local filesyste
    container:src_path dest_path|-
    src_path|- container:dest_path
docker diff: inspect the change of a container's filesystem
docker exec: run a command in a running container
docker history: show the history of image
docker info: system wide information of docker engine
docker kill: kill one or more running containers
docker logs: fetch the logs of a container

docker plugin: enhancement of docker engine
docker wait: block until a container stops then print its exit code


docker inspect <container> 
    -f: format

docker import rally.tar rally:latest


docker export -o output.tar <container-id> 导出container
docker import output.tar  产生镜像

docker save -o output.tar <image> 导出镜像
docker load -i output.tar
```
