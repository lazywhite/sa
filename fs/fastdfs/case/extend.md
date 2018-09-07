# 目标
为tracker3 添加group6存储组
 
## 相关信息
	222.73.19.178   192.168.0.41  img01.thumb.local.info  蓝讯
	222.73.19.174   192.168.0.67  img02.thumb.local.info  网宿
	222.73.19.175   192.168.0.64  img01.local.info
	114.80.215.164  10.8.26.10    img02.local.info
					192.168.0.232 tracker_grp3
					192.168.0.235 tracker_grp3
					192.168.0.64  group3-store1
					10.8.26.10    group3-store2
					10.8.26.13    group6-store1
					10.8.26.14    group6-store2     

## 安装
### 所需软件版本
	FastDFS_v4.06.tar.gz            
	libevent-1.4.13-stable.tar.gz    
	nginx-1.2.1.tar.gz 
注意： 操作目录均为/usr/local/src  
### 步骤
1. libevent   
	tar xf libevent-1.4.13-stable.tar.gz;cd libevent-1.4.13-stable;./configure; make install  
2. fastdfs  
	tar xf FastDFS_v4.06.tar.gz;cd FastDFS;./make.sh;./make.sh install  
3. nginx    
	yum install pcre-devel  
	tar xf nginx-1.2.1.tar.gz;cd nginx-1.2.1;./configure --prefix=/usr/local/nginx;make install


## 配置  
见附件  
文件说明：

	文件名				        文件位置  
	nginx-img01.conf          192.168.0.64:/etc/nginx/nginx.conf  
	img01.local.info.conf    192.168.0.64:/etc/nginx/conf.d/img01.local.info.conf
	nginx-10.8.26.13.conf     10.8.26.13:/usr/local/nginx/conf/nginx.conf
	store_grp6_nginx.conf     10.8.26.13:/usr/local/nginx/conf/conf.d/store_grp6.conf
	storage_grp6.conf		  10.8.26.13:/usr/etc/storage_grp6.conf
    trakcer_grp3.conf         192.168.0.232:/usr/etc/tracker_grp3.conf
	
## 运行
注意： img01.local.info 与img02.local.info 所需操作相同  
10.8.26.13 与 10.8.26.14 所需操作相同    
 
	/usr/local/bin/fdfs_storaged /usr/etc/storage_grp6.conf  
	/path/to/nginx -s reload

## 遇到的问题
1. **img01.thumb.local.info 无法ping通group6 两台存储节点的问题**   
	route add -net 10.8.26.0/24 gw 192.168.0.254 dev em1
2. **缩略图无法正常生成**  
    /home[1]/img01.thumb.local.info/cache/thumb.php 修改bug
