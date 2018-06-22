# on registry node
```
docker run -d -p 5000:5000 --name registry registry:2
```


# on client node
```
docker pull nginx
docker image tag nginx localhost:5000/local-nginx
docker push localhost:5000/local-nginx

# another client
docker pull localhost:5000/local-nginx
```

# tips
```
docker push error: server gave HTTP response to HTTPS client
    /etc/docker/daemon.json
        {
            "insecure-registries": [
                "registry:5000"
            ]
        }

查看镜像列表
    $ curl http://registry:5000/v2/_catalog
    {"repositories":["local-nginx"]}
查看某个镜像的所有tag
    $ curl http://registry:5000/v2/local-nginx/tags/list
    {"name":"local-nginx","tags":["latest"]}
```
