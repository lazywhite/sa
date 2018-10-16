## Topic
### 1. rewrite
```
flag
    last – Stops execution of the rewrite directives in the current server or location context, but NGINX Plus searches for locations that match the rewritten URI, and any rewrite directives in the new location are applied (meaning the URI can be changed again).
    break – Like the break directive, stops processing of rewrite directives in the current context and cancels the search for locations that match the new URI. The rewrite directives in the new location are not executed.
    redirect 301
    permanent 302
```

### 2. server log file through html 
```
server {
    listen       8000 default_server;
    autoindex on;
    disable_symlinks off;
    autoindex_exact_size off;
    autoindex_localtime on;
    charset utf-8;

   location /logs/bookcombined {
        alias  /home/tool/tomcat_book/logs;
    }
}

```
```
mime.types 

    types {
      text/plain                            txt out log; ## logfile suffix
    }

```
## 3. modules
```
1. nginx-sticky-module:
    http://code.google.com/p/nginx-sticky-module/wiki/Documentation
    基于cookie->JSESSIONID的rs分配, 不能与ip_hash一起使用, 可设置expire参数

2. nginx-stub_status:
    ./configure --with-http_stub_status_module
    location /basic_status {
    stub_status;
}

3. nginx -V: list all configured modules

4. nginx-module-vts:  virtual host traffic status module
    https://github.com/vozlt/nginx-module-vts
```

## 4. how nginx process a request

[request process doc](http://nginx.org/en/docs/http/request_processing.html)
1. decides which server should process the request by "Host" header
    if this value doesn't match any server name or value is null, nginx will 
    route this request to default server
    if you don't allow request withou "Host" header, you can define a vhost whose
    server name is ""
2. nginx first searches for the most specific prefix location given by literal strings regardless of the listed order. 


## 5. nginx status
```
Active connections
    The current number of active client connections including Waiting connections.
accepts
    The total number of accepted client connections.
handled
    The total number of handled connections. Generally, the parameter value is the same as accepts unless some resource limits have been reached (for example, the worker_connections limit).
requests
    The total number of client requests.
Reading
    The current number of connections where nginx is reading the request header.
Writing
    The current number of connections where nginx is writing the response back to the client.
Waiting
    The current number of idle client connections waiting for a request.

```
## 6. location匹配
```
1. location 匹配的优先级跟在配置文件中定义的顺序无关
2. @ location别名
    error_page 404 = @fetch;
    location @fetch{
        proxy_pass http://fetch;
    }
3. location 参数有两种 "prefix string" , "regular expresion"
    "prefix string" 从url最开始进行匹配
4. 匹配顺序
    = (exact match), 如果匹配, 停止继续匹配
    ^~ 对"prefix string" 进行最长匹配, 如果成功匹配不进行正则匹配
    存储longest prefix string
    对存储的prefix string进行正则匹配
    在第一个匹配到的正则处break
    如果没有正则匹配到, 使用前两步存储的location配置

    匹配优先级
        1. 精确匹配最高
        2. 最长prefix string匹配次之
        3. 正则匹配最低
    
```

## 7. path alias
```
location = /swagger.yaml {
    alias /root/dashboard/extra/swagger.yaml;
}
```

## 8 .nginx-1.8.1 编译安装
```
yum -y install pcre-devel zlib-devel openssl-devel
./configure --prefix=/usr/local/nginx
```

## 9. nginx 源安装
```
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/$basearch/
gpgcheck=0
enabled=1
```

## 10. yum安装
```
yum -y install epel-release
yum -y install nginx
```
