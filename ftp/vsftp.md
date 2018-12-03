yum -y install vsftpd ftp
/etc/vsftpd/vsftpd.conf
    listen_ipv4=YES
    listen_ipv6=NO
    use_localtime=YES # 使用本地时间
systemctl start vsftpd

# 默认使用系统账户登录

