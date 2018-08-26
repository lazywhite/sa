https://www.server-world.info/en/note?os=CentOS_7&p=drbd9&f=1

打包
    drbdmanage需要yum -y install pygobject2
    drbd-utils需要联网

安装
    需要kernel跟打包机版本一致
    yum -y install pygobject2

    /etc/hosts
        192.168.1.1  node1
        192.168.1.2  node2
    

使用
    (all): vgcreate drbdpool /dev/sda
    (node1): drbdmanage init 192.168.1.1
    (node1): drbdmanage add-node node2 192.168.1.2 # 返回加入命令
    (node2): drbdmanage join -p 6999 192.168.0.2 1 node1 192.168.0.1 0 twuZE5BAthnZIRyEAAS/ 

    drbdmanage list # 查看子命令
    drbdmanage list-nodes # 查看集群节点
    drbdmanage list-resources
    drbdmanage add-resource share-data
    drbdmanage add-volume share-data 100GB
    drbdmanage add-volume share-data 100GB
    drbdmanage list-volumes # 同一个resource可以有多个volume, 有不同的Volume ID和Minor ID
    drbdmanage deploy-resource web 2 # 部署到n个节点
    drbdadm status # 查看同步状态
    (node1): drbdadm primary share-data
    (node1): mkfs.xfs /dev/drbd100
    (node1): mount /dev/drbd100 /mnt
    (node2): drbdadm secondary share-data

    drbd-overview
    drbd-top



扩容drbdpool
    (all)vgextend drbdpool /dev/sdc 
    (node1)dbrdmanage update-pool
    (node1)lsblk # 新磁盘会在被使用时创建对应分区


1. please disable drbd.service Unless you are NOT using a cluster manager.
2. 可以创建不大于pool size的任意大小volume
3. drbdmange restart
