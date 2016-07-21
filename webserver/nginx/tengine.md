## installation
```
1. yum -y install jemalloc-devel lua-devel
2. install library
openssl-1.0.1t
zlib-1.2.8
pcre-8.36
nginx-module-vts

3. add nginx user; install nginx
wget http://tengine.taobao.org/download/tengine-2.1.2.tar.gz

./configure --prefix=/wdzj/lnmp/tengine --user=nginx --group=nginx  --with-http_dyups_module --with-http_dyups_lua_api --with-poll_module --with-http_gzip_static_module --with-jemalloc --with-select_module --with-file-aio --with-http_lua_module --with-pcre --with-http_realip_module  --with-http_gunzip_module --with-http_gzip_static_module --with-http_sysguard_module --with-http_v2_module --with-http_addition_module  --with-http_sub_module  --with-http_concat_module --with-http_secure_link_module  --with-http_degradation_module --add-module=/wdzj/source/nginx-module-vts --with-pcre=/wdzj/source/pcre-8.36 --with-openssl=/wdzj/source/openssl-1.0.1t --with-zlib=/wdzj/source/zlib-1.2.8

make install

```
## Caution
--with-openssl=/path/to/openssl-source
