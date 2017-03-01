
```
Internet iStorage Name Service Server

The Internet Storage Name Service (iSNS) protocol is used for interaction between iSNS servers and iSNS clients. iSNS clients are computers, also known as initiators, that are attempting to discover storage devices, also known as targets, on an Ethernet network. iSNS facilitates automated discovery, management, and configuration of iSCSI and Fibre Channel devices (using iFCP gateways) on a TCP/IP network.


iSCSI Drvier Feature:
支持数据报文首部或数据验正；
CHAP认证
MultiPATH
动态target discover


准备分区或磁盘
创建target
创建lu
添加target授权
发现target
挂载target
/etc/tgtd/target.conf
/etc/iscsi/iscsid.conf



Target:

1、准备要共享的设备，这里使用本地磁盘上的新分区：

# fdisk -l 

建立所需要的新分区
# fdisk /dev/sda

# partprobe 

2、安装iscsi服务端：

# yum -y install scsi-target-utils

# service tgtd start
# chkconfig tgtd on
# netstat -tnlp | grep 3260

3、服务端配置管理工具tgtadm的使用：

tgtadm --lld [driver] --op [operation] --mode [mode] [OPTION]...

(1)、添加一个新的 target 且其ID为 [id]， 名字为 [name].
--lld [driver] --op new --mode target --tid=[id] --targetname [name]

(2)、显示所有或某个特定的target:
--lld [driver] --op show --mode target [--tid=[id]]

(3)、向某ID为[id]的设备上添加一个新的LUN，其号码为[lun]，且此设备提供给initiator使用。[path]是某“块设备”的路径，此块设备也可以是raid或lvm设备。lun0已经被系统预留。
--lld [driver] --op new --mode=logicalunit --tid=[id] --lun=[lun] --backing-store [path]

(4)、删除ID为[id]的target:
--lld [driver] --op delete --mode target --tid=[id]

(5)、删除target [id]中的LUN [lun]：
-lld [driver] --op delete --mode=logicalunit --tid=[id] --lun=[lun]

(6)、定义某target的基于主机的访问控制列表，其中，[address]表示允许访问此target的initiator客户端的列表：
--lld [driver] --op bind --mode=target --tid=[id] --initiator-address=[address]

(7)、解除target [id]的访问控制列表中[address]的访问控制权限：
--lld [driver] --op unbind --mode=target --tid=[id] --initiator-address=[address]

例如：

(1)创建一个target:
# tgtadm --lld iscsi --op new --mode target --tid 1 -T iqn.2013-05.com.test:tsan.disk1


(2)显示所有：
# tgtadm --lld iscsi --op show --mode target

(3)显示刚创建的target:
# tgtadm --lld iscsi --op show --mode target --tid 1

(4)创建LUN，号码为1:
# tgtadm --lld iscsi --op new --mode logicalunit --tid 1 --lun 1 -b /dev/sda5

(5)开放给192.168.0.0/24网络中的主机访问：
# tgtadm --lld iscsi --op bind --mode target --tid 1 --initiator-address 172.16.0.0/16
其中的-I相当于--initiator-address

(6)Create a new account:
# tgtadm --lld iscsi --op new --mode account --user christina --password 123456
# tgtadm --lld iscsi --op show --mode account

Assign this account to a target:

# tgtadm --lld iscsi --op bind --mode account --tid 1 --user christina
# tgtadm --lld iscsi --op show --mode target

(7)Set up an outgoing account. First, you need to create a new account like the previous example

# tgtadm --lld iscsi --op new --mode account --user clyde --password 123456
# tgtadm --lld iscsi --op show --mode account

# tgtadm --lld iscsi --op bind --mode account --tid 1 --user clyde --outgoing
# tgtadm --lld iscsi --op show --mode target

客户端配置:

# yum install iscsi-initiator-utils
 
 客户端命名
# echo "InitiatorName=`iscsi-iname -p iqn.2013-05.com.test`" > /etc/iscsi/initiatorname.iscsi
# echo "InitiatorAlias=initiator1" >> /etc/iscsi/initiatorname.iscsi

# service iscsi start
# chkconfig iscsi on

2、iscsiadm工具的使用：

iscsiadm是个模式化的工具，其模式可通过-m或--mode选项指定，常见的模式有discoverydb、node、fw、session、host、iface几个，如果没有额外指定其它选项，则discoverydb和node会显示其相关的所有记录；session用于显示所有的活动会话和连接，fw显示所有的启动固件值，host显示所有的iSCSI主机，iface显示/var/lib/iscsi/ifaces目录中的所有ifaces设定。

iscsiadm -m discovery [ -d debug_level ] [ -P printlevel ] [ -I iface -t type -p ip:port [ -l ] ] 
iscsiadm -m node [ -d debug_level ] [ -P printlevel ] [ -L all,manual,automatic ] [ -U all,manual,automatic ] [ [ -T tar-getname -p ip:port -I iface ] [ -l | -u | -R | -s] ] [ [ -o operation ] 

-d, --debug=debug_level   显示debug信息，级别为0-8；
-l, --login
-t, --type=type  这里可以使用的类型为sendtargets(可简写为st)、slp、fw和 isns，此选项仅用于discovery模式，且目前仅支持st、fw和isns；其中st表示允许每个iSCSI target发送一个可用target列表给initiator；
-p, --portal=ip[:port]  指定target服务的IP和端口；
-m, --mode op  可用的mode有discovery, node, fw, host iface 和 session
-T, --targetname=targetname  用于指定target的名字
-u, --logout 
-o, --op=OPEARTION：指定针对discoverydb数据库的操作，其仅能为new、delete、update、show和nonpersistent其中之一；
-I, --interface=[iface]：指定执行操作的iSCSI接口，这些接口定义在/var/lib/iscsi/ifaces中；



# iscsiadm -m discovery -t sendtargets -p 192.168.0.11
# iscsiadm -m node -T iqn.2010-8.com.example.ts:disk1 -p 192.168.0.11:3260 -l

# iscsiadm -m node -T iqn.2010-8.com.example.ts:disk1 -p 192.168.0.11:3260 -u
# iscsiadm -m node -T iqn.2010-8.com.example.ts:disk1 -p 192.168.0.11:3260 -o delete
   
查看会话相关信息：
# iscsiadm -m session -s

挂载时使用_netdev作为选项
创建服务端谁所需要的帐号，并实现单方向的认证：

1、在target端创建帐号christina，并为其授予访问某tid的权限：
# tgtadm --lld iscsi --op new --mode account --user mageedu --password 123456

接下来还要将用户与某target进行绑定：
# tgtadm --lld iscsi --op bind --mode account --tid 1 --user mageedu

# tgtadm --lld iscsi --op show --mode account

2、编辑initiator端主配置文件，配置客户端登录target时使用此帐号和密码：
# vim /etc/iscsi/iscsid.conf

取消如下项的注释：
# node.session.auth.authmethod = CHAP
# node.session.auth.username = username
# node.session.auth.password = password

而后，将后两项的用户名密码设置为target端设置的用户名和密码：
node.session.auth.username = christina
node.session.auth.password = 123456

如果此前尚未登录过此target，接下来直接发现并登入即可。否则，则需要按照下面的第三步实现认证的启用。

3、如果initiator端已经登录过此target，此时还需要先注销登录后重启iscsid服务，并在删除此前生成的database后重新发现target，并重新登入，过程如下：

# iscsiadm -m session -r sid -u

# iscsiadm -m node -T iqn.2010-8.com.example.ts:disk1 -p 192.168.0.11:3260 -u
# iscsiadm -m node -T iqn.2010-8.com.example.ts:disk1 -p 192.168.0.11:3260 -o delete
# rm -rf /var/lib/iscsi/nodes/iqn.2010-08.com.example.tgt:disk1
# rm -rf -rf /var/lib/iscsi/send_targets/192.168.0.11,3260
# service iscsid restart

# iscsiadm -m discovery -t sendtargets -p 192.168.0.11
# iscsiadm -m node -T iqn.2010-8.com.example.ts:disk1 -p 192.168.0.11:3260 -l

中的target名字和target主机地址可能需要按照您的实际情况修改。 



```