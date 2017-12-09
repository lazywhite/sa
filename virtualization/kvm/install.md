[centos 7]
yum install kvm libvirt virt-install qemu-kvm virt-viewer bridge-utils

/etc/init.d/libvirtd 
    listen_tcp = 1    
    tcp_port = "16509"

systemctl start libvirtd

