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

## ubuntu
```
千万不要在系统安装时选择docker, 是通过snap安装的， 正确安装方式参考https://docs.docker.com/engine/install/ubuntu/

如何卸载docker snap
    snap remove docker
    rm -rf /var/lib/docker
    apt-get remove docker docker-engine docker.io
```
