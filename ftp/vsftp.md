yum -y install vsftpd ftp

/etc/vsftpd/vsftpd.conf
    listen_ipv4=YES
    listen_ipv6=NO
    use_localtime=YES # 使用本地时间

    # 被动模式配置
    pasv_enable=YES
    pasv_min_port=1025
    pasv_max_port=2048

    pam_service_name=vsftpd
    userlist_enable=YES
    tcp_wrappers=YES

    max_per_ip=1000  # 单IP并发连接数
    allow_writeable_chroot=YES # 允许ftp家目录可写

systemctl start vsftpd

# 默认使用系统账户登录
