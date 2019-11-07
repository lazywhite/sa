yum -y install sysstat

sar -n DEV 1 # 监测网卡流量

sar -n SOCK
 totsck: 系统持有的socket个数；
 tcpsck: 当前正在使用的tcp socket的个数；
 ip-frag: 当前正在使用ip分片的个数；
 tcp-tw: 处于tw状态的tcp套接字的个数；


# 查看所有磁盘设备, 每秒一次
sar -d 1 # 单位为0.5B
iostat 1 # 单位为KB
