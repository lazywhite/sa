## 前提
```
1. 确保主机名解析
/etc/hosts
    192.168.1.1 node1
    192.168.1.2 node2
2. 确保时间同步
3. 关闭selinux, iptables
4. 防止交换机链路聚合lb的影响
```

## 安装
```

yum install pacemaker pcs resource-agents

版本信息
[root@node2 ~]# rpm -qa|grep pacemaker
pacemaker-cluster-libs-1.1.18-11.el7_5.3.x86_64
pacemaker-1.1.18-11.el7_5.3.x86_64
pacemaker-cli-1.1.18-11.el7_5.3.x86_64
pacemaker-libs-1.1.18-11.el7_5.3.x86_64
[root@node2 ~]# rpm -qa|grep pcs
pcs-0.9.162-5.el7.centos.1.x86_64
[root@node2 ~]# rpm -qa|grep corosync
corosync-2.4.3-2.el7_5.1.x86_64
corosynclib-2.4.3-2.el7_5.1.x86_64

/etc/sysconfig/pcsd  # debug and gui
gui: https://<ip>:2224

```
## 搭建
```

(all)systemctl start pcsd
(all)systemctl enable pcsd

(all) echo 'hacluster' | passwd hacluster --stdin
(one) pcs cluster auth -u hacluster -p hacluster --force node1 node2
(one) pcs cluster setup --force --name cluster node1 node2 ## 自动生成/etc/corosync/corosync.conf
(one) pcs cluster start --all
(one) pcs cluster status
(one) pcs cluster enable --all # 设置开机启动
(one) pcs status # 查看集群状态
(one) corosync-cfgtool -s # 查看集群通信
(one) pcs status corosync

(one) crm_mon -1 # 查看集群状态
(one) crm_mon # watch

```
## 配置
```
## set cluster options
(one) pcs property set stonith-enabled=false # 关闭stonith设备
(one) pcs property set no-quorum-policy=ignore # 设置仲裁策略

## add cluster resources

pcs resource # list all resource
pcs resource show <resource>

# 获取resource agent帮助
pcs resource describe ocf:heartbeat:nfsnotify 
    This agent sends NFSv3 reboot notifications to clients which informs clients to reclaim locks.


pcs resource defaults resource-stickiness=100 # 设置默认资源粘性
pcs resource op defaults timeout=240s # 资源start, stop, monitor默认时间为20s
pcs constraint location <res> prefers node2=INFINITY # 设置资源偏好, 可以为数字score

```


## 常用命令
```

pcs cluster cid # xml格式查看集群配置


[root@node4 ~]# pcs resource standards
lsb
ocf
service
systemd

[root@node4 ~]# pcs resource providers
heartbeat
openstack
pacemaker

pcs constraint # 查看资源约束
    location
    order
    colocation
    ticket
   
# 查看resource agents
pcs resource agents ocf:heartbeat
pcs resource agents systemd

pcs cluster standby node2 # 挂起节点
pcs cluster unstandby node2 # 恢复节点

pcs cluster stop node2 
pcs cluster start node2


# 删除ORPHANED FAILED resource
crm_resource --cleanup <resource-id>

# 删除colocation
pcs constraint colocation remove nfs-share nfs-daemon 
pcs constraint order remove drbd_r0_clone fs


# resource 跟 resource group的colocation, 只需设置resource跟group中某一个resource的colocation即可

# 清除resource相关的Failed action
pcs resource cleanup <resource>
pcs resource cleanup 

# 更新resource定义
pcs resource update nfs-daemon nfs_no_notify=true
pcs resource show nfs-daemon  # 查看resource定义

```

## 资源组
```
# group resource: located together, start sequentially, and stop in the reverse order.

# 删除资源组
pcs resource group remove nfs

# 创建group
pcs resource create --group <group>
pcs resource group add <group> <resource>
```



## 配置drbd8
```
1. 确保drbd service active, enabled
2. drbdadm status 同步正常
3. 节点全部设置为secondary


pcs cluster cib drbd_cfg # 将当前cib保存至drbd_cfg
pcs -f drbd_cfg resource create drbd_r0 ocf:linbit:drbd drbd_resource=r0 drbdconf=/etc/drbd.conf op monitor interval=60s
pcs -f drbd_cfg resource master drbd_r0_clone drbd_r0 master-max=1 master-node-max=1 clone-max=2 clone-node-max=1 notify=true
pcs cluster cib-push drbd_cfg # 将drbd_cfg应用到cib

pcs resource create cluster-ip IPaddr2 \
      ip=172.16.0.200 cidr_netmask=24 op monitor interval=30s # auto start
pcs resource create FS Filesystem device=/dev/drbd112 directory=/share fstype=xfs
pcs resource create nfs-daemon nfsserver nfs_no_notify=true
pcs resource create nfs-share exportfs clientspec=172.31.0.0/255.255.0.0 options="rw,sync,insecure,no_subtree_check,no_root_squash" directory=/share fsid=0
pcs resource create nfs-notify nfsnotify source_host=172.16.0.200


# 要严格注意order
pcs resource group add nfs fs
pcs resource group add nfs cluster_ip --after nfs-share
pcs resource group add nfs nfs-daemon --after cluster_ip
pcs resource group add nfs nfs-share --after nfs-daemon
pcs resource group add nfs nfs-notify --after nfs-share
pcs constraint colocation add fs with master drbd_r0_clone INFINITY # master role
pcs constraint order promote drbd_r0_clone then fs # promote action


Full list of resources:

 Master/Slave Set: drbd_r0_clone [drbd_r0]
     Masters: [ node4 ]
     Slaves: [ node5 ]
 Resource Group: nfs
     fs (ocf::heartbeat:Filesystem):    Started node4
     cluster_ip (ocf::heartbeat:IPaddr2):       Started node4
     nfs-daemon (ocf::heartbeat:nfsserver):     Started node4
     nfs-share  (ocf::heartbeat:exportfs):      Started node4
     nfs-notify (ocf::heartbeat:nfsnotify):     Started node4




# 确保关闭selinux
lrmd[2163]:drbd_monitor_60000:4673:stderr [ Error signing on to the CIB service: Transport endpoint is not connected ]

# 权限错误需要reboot
Aug 29 10:07:48 node5 lrmd[5061]:  notice: drbd_r0_stop_0:24776:stderr [ Command 'drbdsetup-84 secondary 0' terminated with exit code 20 ]
Aug 29 10:07:48 node5 lrmd[5061]:  notice: drbd_r0_stop_0:24776:stderr [ open(/var/lock/drbd-147-0): Permission denied ]

```



