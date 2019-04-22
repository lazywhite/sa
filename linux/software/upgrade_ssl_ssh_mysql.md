卸载openssh-server  

## 1. Install Openssl
```
wget https://www.openssl.org/source/openssl-1.0.2k.tar.gz
yum -y install zlib-devel
./config shared --prefix=/usr/local/ssl --openssldir=/usr/local/ssl
echo "/usr/local/ssl/lib" >  /etc/ld.so.conf.d/openssl.conf
ldconfig
```

## 2. Install Openssh
```
openssh-7.5 will not compile with openssl-1.1.x 
wget ftp://ftp.kddilabs.jp/pub/OpenBSD/OpenSSH/portable/openssh-7.5p1.tar.gz
yum -y install pam-devel
./configure --prefix=/usr/local/openssh --sysconfdir=/etc/ssh --with-pam --with-ssl-dir=/usr/local/ssl --with-md5-passwords --mandir=/usr/share/man 
```

## 2.2 /etc/pam.d/sshd
```
#%PAM-1.0
auth       required pam_sepermit.so
auth       include      password-auth
account    required     pam_nologin.so
account    include      password-auth
password   include      password-auth
# pam_selinux.so close should be the first session rule
session    required     pam_selinux.so close
session    required     pam_loginuid.so
# pam_selinux.so open should only be followed by sessions to be executed in the user context
session    required     pam_selinux.so open env_params
session    optional     pam_keyinit.so force revoke
session    include      password-auth
```


## 2.3 /etc/ssh/sshd_config
```
Protocol 2
SyslogFacility AUTHPRIV
PermitRootLogin yes
PasswordAuthentication yes
ChallengeResponseAuthentication no
UsePAM yes
AcceptEnv LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES
AcceptEnv LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT
AcceptEnv LC_IDENTIFICATION LC_ALL LANGUAGE
AcceptEnv XMODIFIERS
X11Forwarding no
Subsystem   sftp    /usr/libexec/openssh/sftp-server
```
## 3. Install MySQL 5.6.35
```
yum -y install  gcc gcc-c++ gcc-g77 autoconf automake zlib* fiex* libxml* ncurses-devel libmcrypt* libtool-ltdl-devel* make cmake
# 源码 wget http://cdn.mysql.com/Downloads/MySQL-5.6/mysql-5.6.35.tar.gz
# 编译版  wget -q http://mirrors.sohu.com/mysql/MySQL-5.6/mysql-5.6.35-linux-glibc2.5-x86_64.tar.gz

# 编译命令
cmake \
-DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
-DMYSQL_DATADIR=/usr/local/mysql/data \
-DSYSCONFDIR=/etc \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_MEMORY_STORAGE_ENGINE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DMYSQL_UNIX_ADDR=/var/lib/mysql/mysql.sock \
-DMYSQL_TCP_PORT=3306 \
-DENABLED_LOCAL_INFILE=1 \
-DEXTRA_CHARSETS=all \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DWITH_SSL=/usr/local/ssl
```
