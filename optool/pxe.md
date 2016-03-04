1、依赖的服务：dhcp, tftp, fileserver(http,ftp,nfs);
2、kickstart;

```
# yum install tftp-server dhcp vsftpd syslinux

next-server 172.16.100.1;    //指向tftp服务器
filename="pxelinux.0";  //tftp根目录的相对路径

# mount /dev/cdrom /var/ftp/pub

# cp /var/ftp/pub/images/pxeboot/{vmlinuz,initrd.img}  /var/lib/tftpboot/
# cp /var/ftp/pub/isolinux/{boot.msg,vesamenu.c32,splash.jpg}  /var/lib/tftpboot/
# cp /usr/share/syslinux/pxelinux.0  /var/lib/tftpboot/

# mkdir /var/lib/tftpboot/pxelinux.cfg
# cp /var/ftp/pub/isolinux/isolinux.cfg  /var/lib/tftpboot/pxelinux.cfg/default
 ```
