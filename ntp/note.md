## installation
```
# centos7
yum -y install ntp

# modify /etc/ntp.conf  

systemctl start ntpd
systemctl enable ntpd

ntpq -p # 查看同步状态
```
