## install guid
OS:centos6.5
gluster:3.7.3

## procedure
```
rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

yum install automake autoconf libtool flex bison openssl-devel libxml2-devel python-devel\
libaio-devel libibverbs-devel librdmacm-devel readline-devel lvm2-devel glib2-devel \
userspace-rcu-devel libcmocka-devel libacl-devel sqlite-devel  userspace-rcu-devel

./autogen.sh
./configure --prefix=/usr --enable-debug

cat > /etc/ld.so.conf.d/gluster.conf/gluster-3.7.3.conf <<EOF
/usr/lib
EOF
ldconfig


```