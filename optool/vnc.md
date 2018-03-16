## on centos-7
```
yum install tigervnc-server
vncpasswd  --> /home/<User>/.vnc/passwd
运行
    vncserver 
设置分辨率
    vncserver -geometry 1280x800 (default 1027x768)

强制停止vnc进程清理文件
    /tmp/.X1-lock
    /tmp/.X11-unix/X1 

停止桌面
    vncserver -kill :1 
```
## configuration file
```
/lib/systemd/system/vncserver@.service
/etc/sysconfig/vncserver
```

## client
```
Mac screen sharing vnc server必须要配置密码
vnc://192.168.x.x:5900 仅支持端口号连接
```
