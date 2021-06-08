
## vbox 扩大硬盘容量
```
VBoxManage clonehd work-disk1.vmdk new.vdi --format vdi
VBoxManage modifyhd new.vdi --resize 20480
cfdisk /dev/sda # add partition
vgextend vg /dev/sda5
lvextend -l +100%FREE /dev/vg/lv_root
resize2fs /dev/vg/lv_root
```

## vbox shrink vdisk
```
dd if=/dev/zero of=/empty bs=1M
rm -f /empty
halt
VBoxManage modifyhd new.vdi --compact
```

## headless
```
VBoxManage startvm ubuntu --type headless
VBoxManage controlvm ubuntu poweroff
VBoxManage controlvm ubuntu  pause
VBoxManage controlvm ubuntu reset
```

## tips
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

        centos: 
            yum update kernel #reboot
            yum -y install kernel-devel  kernel-headers gcc
        ubuntu:
            apt install build-essential dkms linux-headers-$(uname -r)

        cd /mnt/; ./VBoxLinuxAdditions.run
        # 提示warning: no xorg found, 可以忽略
        无需重启guest, 可直接设置共享，进行挂载
    设置共享
        添加共享文件夹
            路径： d:\
            名称： dir1
        linux vm
            mount -t vboxsf dir1 /mnt
            不能写进/etc/fstab, 无法自动挂载, 会导致无法启动
        windows vm
            此电脑--> 映射网络驱动器
            \\vboxsvr\tmp

vm网络连接找不到host网卡列表
    适配器设置-->属性-->安装-->服务-->添加-->vbox/driver/network/netlwf/vboxnetlwf
    https://blog.csdn.net/qq_383698639/article/details/79527311


mac host-only出外网
    /etc/pf.conf
        rdr-anchor "com.apple/*"    ## 此行后面添加
        nat on en0 from 192.168.56.0/24 to any -> en0
        pass from {lo0, 192.168.56.0/24} to any keep state
    sysctl -w net.inet.ip.forwarding=1
    sudo pfctl -vnf /etc/pf.conf  # 检查配置文件
    sudo pfctl -ef /etc/pf.conf  # 应用
    重启后会失效
```

## 备份占据超大空间
```
备份30G, 磁盘10G，删除备份需要合并两个盘，需要额外的50G空闲空间
如果实在没有那么多空闲空间， 可以直接删除备份文件，但会丢失磁盘内的数据, 需要实现把重要文件备份在宿主机
然后在界面上删除备份
```

## 开启嵌套虚拟化
```
Enable Nested VT-x/AMD-V: Enables nested virtualization, with passthrough of hardware virtualization functions to the guest VM.
This feature is available on host systems that use an AMD CPU. For Intel CPUs, the option is grayed out.

intel cpu需要输入命令
    VBoxManage.exe list vms
    VBoxManage.exe modifyvm "centos8" --nested-hw-virt on

    启动后报错Cannot enable nested VT-x/AMD-V without nested-paging and unresricted guest execution! 证明无法开启



```
