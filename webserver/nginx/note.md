## Topic
### 1. rewrite

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

