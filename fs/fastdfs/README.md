# Installation
1.fastdfs v4.0
2.libevent v1.4.13
3.nginx v1.6.3

# procedure
libevent
    ./configure --prefix=/usr;make;make install

fastdfs
    ./make.sh
    ./make.sh install
    ldd /usr/local/bin/fdfs_tracker
    ln -s /usr/lib/libevent-1.4.2.so /usr/lib64
nginx
    ./configure --prefix=/usr/local/nginx --add-module=/usr/local/src/fastdfs-nginx-module/src
    make;make install
    cp /usr/local/src/fastdfs-nginx-module/src/mod_fastdfs.conf /etc/fdfs/
# 注意点
tracker节点nginx无需安装fastdfs模块,storage节点均需安装此模块
cd /path/to/storage/group1; ln -s data M00
