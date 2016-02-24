# storage pool
## type
1. disk
2. partition
3. directory
4. lvm
5. iscsi
6. nfs
7. glusterfs
## example: directory base storage pool
<pool type="dir">
        <name>virtimages</name>
        <target>
          <path>/data</path>
        </target>
 </pool>
virsh pool-define /path/to/pool.xml
virsh pool-list --all
virsh pool-start <name>
virsh pool-autostart <name>
# disk-image
virsh vol-create-as --pool <pool name> --name <image name>
virsh vol-create-as --help
# creat a vhost
mount -o loop /path/to/centos6.5.iso /mnt/CentOS-65
virt-install --name vhost_one --ram 2048 --vcpus=4 --location=/mnt/CentOS-65 --disk vol=virtimages:vhost_one.img,bus=virtio --network bridge=br0,model=virtio --extra-args="ks=http://kickstartserver/timtest.cfg text console=tty0 utf8 console=ttyS0,115200" --graphics vnc
