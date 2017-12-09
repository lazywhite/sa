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
```
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
```
# disk-image
```
virsh vol-create-as --pool <pool name> --name <image name>
virsh vol-create-as --help
```
# creat a vhost
```
mount -o loop /path/to/centos6.5.iso /mnt/CentOS-65
virt-install --name vhost_one --ram 2048 --vcpus=4 --location=/mnt/CentOS-65 --disk vol=virtimages:vhost_one.img,bus=virtio --network bridge=br0,model=virtio --extra-args="ks=http://kickstartserver/timtest.cfg text console=tty0 utf8 console=ttyS0,115200" --graphics vnc
```

# create a clone
```
virt-clone --name <clone> --original <name> --file /path/to/disk.qcow2
or 
virt-clone --original <name> --auto-clone
```

# tips
```
1. nat网络连接的虚拟机, 配置vnc server, 指定端口, 可通过宿主机的ip远程连接, realvnc的viewer需要设置连接质量为high, 不能为auto

2. virsh provided by libvirt-client
3. virbr0 默认会被创建,  用net-undefine来删除
```

## snapshot 
```
virsh snapshot-create-as --domain freebsd --name freebsd-origin # 生成快照
virsh snapshot-list --domain freebsd # 列出快照
virsh snapshot-info --domain freebsd --snapshotname freebsd-origin # 快照信息

# 还原为快照
virsh shutdown --domain freebsd
virsh snapshot-revert --domain freebsd --snapshotname freebsd-origin --running

# 删除快照
virsh snapshot-delete --domain freebsd --snapshotname freebsd-origin

```

## net
```
net-list
net-edit default
net-dumpxml default
net-undefine default
net-destroy default

```

## vnc
```
vncdisplay <domain>
vnc开启密码验证
<graphics type='vnc' port='-1' autoport='yes' listen='192.168.1.5' passwd='YOUR-PASSWORD-HERE' keymap='en-us'/>
```


