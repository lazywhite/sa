yum install x11vnc
x11vnc  -storepasswd
x11vnc -forever -rfbauth /root/.vnc/passwd -display :0
