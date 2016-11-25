## 常见状态码
```
201: Created 新的资源已经根据要求创建
202: Accepted 创建新资源的请求已接受, 但尚未处理， 适用在异步场景
204: No Contenet 仅返回头部， 不返回body, 文档视图不需刷新
205: Rese Content 跟204类似, 但需要请求者刷新文档视图
206: partial content 服务器成功处理部分Get请求, 与Range相关头信息一起适用

301: Moved Permanetly 永久重定向
302: Found 临时重定向
304: Not modified 与ETag头部配合适用, 表示没有发生更改
305: Use proxy 被请求的资源必须通过代理才能使用, Location头部将给出代理服务器的URL


400: Bad Request 请求包含语法错误, 服务器无法理解
401: Unauthorized 服务器需要用户提供授权
403: Forbidden 服务器理解请求, 但拒绝执行
404: Not Found 请求的资源在服务器不存在
405: Method not Allowed 请求的方法(request method)不能用于请求的资源(url)
408: Request timeout 客户端请求超时
409: Conflict 被请求的资源当前状态存在冲突
410: Gone 请求的资源在服务器已经不再可用  
411: Length Required 服务器拒绝在缺少content-length的情况下相应请求
412: Precondition Failed 请求资源缺少必要的条件
414: Request URL too long 请求的URL的长度超出了服务器能解析的范围
415: Unsupported media type 不支持的媒体类型
423: Locked 当前资源被锁定


500: Internal Server Error 服务端代码出错
501: Not implemented 服务端不支持当前请求所需要的功能
502: Bad Gateway 无法从上游服务器得到有效响应
503: Service Unavailable 服务器过于繁忙或者正在维护
504: Gateway Timeout 上游服务器返回超时
505: HTTP Version Not Supported 不支持的HTTP协议版本
509: Bandwidth Limit Exceeded 超出带宽限制

```
