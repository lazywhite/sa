## 一、Server
### 1. requirement
```
apt-get install  gcc libcurl4-openssl-dev apache2 mysql-server libapache2-mod-auth-mysql php5-mysql  php5 libapache2-mod-php5 php5-mcrypt php5-mysql libmysql++-dev libcurl4-openssl-dev php5-gd libssh2-1-dev 
```
### 2. install  

```
./configure --prefix=/usr/local/zabbix --enable-server --enable-agent --with-mysql --with-net-snmp --with-libcurl --with-libxml2 --with-unixodbc --with-ssh2 --with-openipmi --with-openssl

cp misc/init.d/debian/zabbix-<server|agent>  /etc/init.d ## modify exec path

create database zabbix charset utf8;
grant all on zabbix.* to 'zabbix_user'@'%' identified by 'zabbix_pwd'

cd database/mysql
mysql -uzabbix_user -p'zabbix_pwd' zabbix < schema.sql
mysql -uzabbix_user -p'zabbix_pwd' zabbix < images.sql
mysql -uzabbix_user -p'zabbix_pwd' zabbix < data.sql


/etc/init.d/zabbix-server start
```



## 二、 Frontend
```

cp -a frontends/php/*  /var/www/html/


/etc/php5/apache2/php.ini
    post_max_size = 16M
    max_execution_time = 300
    max_input_time = 300
    date.timezone = Asia/Shanghai


/etc/init.d/apache2 restart

## http://zabbix.xx.com/ follow setup script


## add zh_CN locales
dpkg-reconfigure locales
cd zabbix/locale/;  ./make_mo.sh
/etc/init.d/apache2 restart

User Profile --> Langugage --> Select zh_CN

## add chinese font
cp msyh.ttf   /var/www/html/zabbix/fonts/
./include/defines.inc.php
    define('ZBX_FONTPATH',              realpath('fonts')); // where to search for font (GD > 2.0.18)
    define('ZBX_GRAPH_FONT_NAME',       'msyh'); // font file name
    define('ZBX_FONT_NAME', 'msyh');

```


### 三、 Agent
```
./configure --enable-agent --prefix=/usr/local/zabbix

```

### 四、 Proxy
```
useradd zabbix -M -s /sbin/nologin

apt-get install  mysql-server libsnmp-dev libmysql++-dev  libssh2-1-dev
./configure --prefix=/usr/local/zabbix --enable-proxy --with-net-snmp --with-mysql --with-ssh2
create database zabbix_proxy charset utf8;
grant all on zabbix_proxy.* to 'zabbix_user'@'%' identified by 'zabbix_pwd'
mysql -uzabbix_user -p'zabbix_pwd' zabbix_proxy < schema.sql

/etc/init.d/zabbix_proxy start
```



