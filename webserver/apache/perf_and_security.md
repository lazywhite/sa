# 一、 性能调优
## 1.1 MPM模式
prefork: 多进程  
worker: 多进程+多线程  
event: 跟work类似，用单独的线程处理Keepalive, Idel连接. 2.4版本以上可用  
  
```
conf/httpd-mpm.conf
    MaxClients # 单个进程最大线程数
    ServerLimit #最大进程数
    StartServer #初始进程数 
    MinSpareServers #最小空闲进程数
    MaxSpareServers #最大空闲进程数
    MaxRequestsPerChild #进程重新释放阈值
```
## 1.2 开启AJP协议支持
```
mod_proxy_ajp 
    替代http协议， 获得更好的反向代理性能
```
## 1.3 禁用DNS inqueries
```
HostnameLookups off
```
## 1.4 启用Keepalive
```
KeepAlive on
KeepAliveTimeout 5

```
## 1.5 启用Http压缩
```
FilterDeclare gzipping CONTENT_SET
FilterProvider gzipping deflate Content-Type text/css
FilterProvider gzipping deflate Content-Type $javascript
FilterChain gzipping

```
## 1.6 减少不必要的模块载入
apache模块分为static和shared两种，可以通过`apache2ctl -M`查看, 然后用重新  
编译来禁用静态模块或者a2enmod, a2dismod命令去管理动态模块
## 1.7 开启sendfile支持
```
EnableSendfile on
```

## 1.8 关闭额外状态统计
```
ExtendedStatus off
```

# 二、安全加固
## 2.1 隐藏版本信息
```
ServerSignature Off
ServerTokens Prod
```
可通过重新编译apache来完全隐藏版本信息  

## 2.2 禁用目录列表
```
<Directory /var/www/html>
Options -Indexes
</Directory>
```

## 2.3 用普通用户运行apache进程
```
User apache
Group apache
```
## 2.4 目录访问权限控制
```
<Directory />
    Options None
    Order deny,allow
    Deny from all
</Directory>
```
## 2.5 开启安全模块
根据访问频率，并发数来防止暴力攻击
```
conf/http.conf
    mod_security
    mod_evasive 
```
## 2.6 限制访问数据大小
```
<Directory "/var/www/myweb1/user_uploads">
LimitRequestBody 512000
</Directory>
```
## 2.7 禁用ServerSide Include
```
<Directory "/var/www/html/web1">
    Options -Includes 
    Options -ExecCGI
</Directory>
```
## 2.8 禁止通过修改.htaccess文件覆盖配置
```
<Directory "/">
    AllowOverride None
</Directory>
```
