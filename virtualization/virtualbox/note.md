## 挂载共享文件夹
```
\\vboxsvr\tmp
```

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
