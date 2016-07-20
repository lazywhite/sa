## issue
openssl heart bleed will affect versions older than 1.0.1f

## installation
```
wget https://www.openssl.org/source/openssl-1.0.1t.tar.gz  
tar xf openssl-1.0.1t.tar.gz  
./config --prefix=/usr/local/openssl -DOPENSSL_USE_IPV6=0  
make install  
```
