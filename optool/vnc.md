## on centos-7
yum install tigervnc-server
vncpasswd  --> /home/<User>/.vnc/passwd
vncserver 
## configuration file
/lib/systemd/system/vncserver@.service
/etc/sysconfig/vncserver

## client
Mac screen sharing vnc server必须要配置密码
vnc://192.168.x.x:5900 仅支持端口号连接
