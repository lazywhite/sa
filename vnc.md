## on centos-7
yum install tigervnc-server
vncpasswd  --> /home/<User>/.vnc/passwd
vncserver 
## configuration file
/lib/systemd/system/vncserver@.service
/etc/sysconfig/vncserver
