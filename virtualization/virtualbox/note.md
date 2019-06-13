
## vbox 扩大硬盘容量
```
VBoxManage clonehd work-disk1.vmdk new.vdi --format vdi
VBoxManage modifyhd new.vdi --resize 20480
cfdisk /dev/sda # add partition
vgextend vg /dev/sda5
lvextent -l 100%FREE /dev/vg/lv_root
resize2fs /dev/vg/lv_root
```

## vbox shrink vdisk
```
dd if=/dev/zero of=/empty bs=1M
rm -f /empty
halt
VBoxManage modifyhd new.vdi --compact
```


host-only vm不通host
    关闭windows防火墙

host-only 通外网
    host设置SNAT

vbox nat
    连接方式： 网络地址转换（NAT）
    高级
        端口转发
            rule1 tcp <blank> 1922 10.0.2.15 22

vbox 共享文件夹
    安装增强功能
        1.  弹出当前光驱ISO
            VM--设备--安装增强功能
        2. 挂载光驱c:\program files\oracle\virtual box\VBoxGuestAdditions.iso
            mount /dev/sr0 /mnt

        
        yum update kernel #reboot
        yum -y install kernel-devel  kernel-headers

        cd /mnt/; ./VBoxLinuxAdditions.run
    设置共享
        添加共享文件夹
            路径： d:\
            名称： dir1
        linux vm
            mount -t vboxsf dir1 /mnt
        windows vm
            此电脑--> 映射网络驱动器
            \\vboxsvr\tmp

vm网络连接找不到host网卡列表
    适配器设置-->属性-->安装-->服务-->添加-->vbox/driver/network/netlwf/vboxnetlwf
    https://blog.csdn.net/qq_383698639/article/details/79527311
