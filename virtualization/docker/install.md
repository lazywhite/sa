# Binary
```
wget https://download.docker.com/linux/static/stable/x86_64/docker-18.03.1-ce.tgz
tar xf docker-18.03.1-ce.tgz -C /usr/local

docker/
    docker
    docker-containerd
    docker-containerd-ctr
    docker-containerd-shim
    dockerd
    docker-init
    docker-proxy
    docker-runc

export PATH=/usr/local/docker:$PATH
dockerd &
```
