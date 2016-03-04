##Header changes in forward-proxy
## Doc
[Proxy-Connection](https://imququ.com/post/the-proxy-connection-header-in-http-request.html)
## 正向代理
```
#Before
GET / HTTP/1.1
Host: www.example.com
Connection: keep-alive
```
```
#After
GET http://www.example.com/ HTTP/1.1   #full url
Host: www.example.com
Proxy-Connection: keep-alive    
```

##不会被代理转发的header
Connection Prxoy-Authenticate、Proxy-Connection、Transfer-Encoding 和 Upgrade
