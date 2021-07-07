## 使用
```
pvdisplay
pvcreate /dev/vdb1
vgcreate vg1 /dev/vdb1
lvcreate -l +100%FREE  -n lv1 vg1
lvcreate -L 30G  -n lv1 vg1
mkfs -t xfs /dev/vg1/lv1
mount -t xfs /dev/vg1/lv1 /mnt
```

## 调整大小
```
lvremove /dev/centos/home
lvextend -l 100%FREE /dev/centos/root
# 根据文件系统选择对应的工具
resize2fs /dev/centos/root # fore ext3, ext4
xfs_growfs / # for xfs
```

## 更换硬盘
```
pvcreate /dev/new_disk # 不用分区
vgextend vg_store /dev/newdisk
pvmove /dev/broken_disk /dev/new_disk
vgreduce vg_store /dev/broken_disk
pvremove /dev/broken_disk
```
