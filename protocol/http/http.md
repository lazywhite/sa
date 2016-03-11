## Doc
[http状态码](https://zh.wikipedia.org/wiki/HTTP%E7%8A%B6%E6%80%81%E7%A0%81)

## note
http协议是无状态的, web程序引入cookie机制来维护状态  
cookie可以人为禁止, 服务端引入session来保存状态  
header与body之间有空行  
request Method 区分大小写, header不区分大小写  

## Get和Post方法的区别
1. get提交的数据会放在url之后, 以?分隔url和传输数据, url长度有限制
2. Post将提交数据放在body中, 所以提交的数据大小没有限制


# Request header
```
GET / HTTP/1.1    # [Method] [URL] HTTP/[version]
HOST: www.example.com
Connection: Keep-Alive
Accept: text/html
Accept-charset: utf-8
Accept-Encoding: gzip,deflate,sdch
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36
Referer: []  #跳转url
Cookie: N_54mrPGUO69y2KhJ0nTH6aoj89HxtKgj68-pe91EG0Pt3lQpYD-5F6aogKK0eOTHvcP; H_BDCLCKID_SF=Jb4DoC0MfIvbfP0k5-n_bnF0bfR-atFDJJ-X3 
```



## Response header
```
Content-Encoding: gzip
Content-Lenght: 40789
Content-Type: text/html;charset=utf-8
Set-Cookie:  ##repeate
Date: Mon, 22 Feb 2016 03:21:50 GMT
Cache-Control: max-age=15552000
Expire: Mon, 22 Feb 2016 03:21:50 GMT
Etag: d669c5046e2ea1505c76edba9fab3f63
Last-Modified: Thu, 01 Jan 1970 00:00:00 GMT
Status: 304 
Server: Tengine

```

