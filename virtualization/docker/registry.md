# on registry node
```
docker run -d -p 5000:5000 --name registry registry:2
```


# on client node
```
docker pull nginx
docker image tag nginx registry:5000/local-nginx

# 允许http协议推送(所有client)
/etc/docker/daemon.json
    {
        "insecure-registries": [
            "registry:5000"
        ]
    }

#client跟registry不能为同一台机器
#push的域名要跟daemon.json的严格一致

(client1) docker push registry:5000/local-nginx

(client2) docker pull registry:5000/local-nginx
```
# High Available
```
redis cache
global storage
```

# tips
```

查看镜像列表
    $ curl http://registry:5000/v2/_catalog
    {"repositories":["local-nginx"]}
查看某个镜像的所有tag
    $ curl http://registry:5000/v2/local-nginx/tags/list
    {"name":"local-nginx","tags":["latest"]}
```
