## Installation
```
yum -y install nfs-utils
```
## Usage
```
for cent6
    servce rpcbind start
    service nfs start

for cent7
    systemctl start rpcbind nfs-server
    systemctl enable rpcbind nfs-server
```

## Configure
```
server
    /etc/exports
        # /path/to/nfs/share <host>(no_root_squash,rw)
        /share 192.168.0.*(rw,sync)

    exportfs -avr 


client
    showmount -e 192.168.56.70

    mount -t nfs 192.168.0.70:/share /mnt
```

## Sync
```
mount -o sync
```


##mount option
```
mount nfs的可选参数：
HARD mount和SOFT MOUNT：
HARD:NFS CLIENT会不断的尝试与SERVER的连接（在后台，不会给出任何提示信息,在LINUX下有的版本仍然会给出一些提示），直到MOUNT上。
SOFT:会在前台尝试与SERVER的连接，是默认的连接方式。当收到错误信息后终止mount尝试，并给出相关信息。
例如：

mount -t nfs -o hard 192.168.0.10:/nfs /nfs
对于到底是使用hard还是soft的问题，这主要取决于你访问什么信息有关。例如你是想通过NFS来运行X PROGRAM的话，你绝对不会希望由于一些意外的情况（如网络速度一下子变的很慢，插拔了一下网卡插头等）而使系统输出大量的错误信息，如果此时你用的是HARD方式的话，系统就会等待，直到能够重新与NFS SERVER建立连接传输信息。另外如果是非关键数据的话也可以使用SOFT方式，如FTP数据等，这样在远程机器暂时连接不上或关闭时就不会挂起你的会话过程。


rsize和wsize：
文件传输尺寸设定：V3没有限定传输尺寸，V2最多只能设定为8k，可以使用-rsizeand -wsize 来进行设定。这两个参数的设定对于NFS的执行效能有较大的影响
bg：在执行mount时如果无法顺利mount上时，系统会将mount的操作转移到后台并继续尝试mount，直到mount成功为止。（通常在设定/etc/fstab文件时都应该使用bg，以避免可能的mount不上而影响启动速度）
fg：和bg正好相反，是默认的参数
nfsvers＝n:设定要使用的NFS版本，默认是使用2，这个选项的设定还要取决于server端是否支持NFS VER 3
mountport：设定mount的端口
port：根据server端export出的端口设定。例如，如果server使用5555端口输出NFS,那客户端就需要使用这个参数进行同样的设定
timeo=n:设置超时时间，当数据传输遇到问题时，会根据这个参数尝试进行重新传输。默认值是7/10妙（0.7秒）。如果网络连接不是很稳定的话就要加大这个数值，并且推荐使用HARD MOUNT方式，同时最好也加上INTR参数，这样你就可以终止任何挂起的文件访问。
intr: 允许通知中断一个NFS调用。当服务器没有应答需要放弃的时候有用处。
udp：使用udp作为nfs的传输协议（NFS V2只支持UDP)
tcp：使用tcp作为nfs的传输协议
namlen=n：设定远程服务器所允许的最长文件名。这个值的默认是255
acregmin=n：设定最小的在文件更新之前cache时间，默认是3
acregmax=n：设定最大的在文件更新之前cache时间，默认是60
acdirmin=n：设定最小的在目录更新之前cache时间，默认是30
acdirmax=n：设定最大的在目录更新之前cache时间，默认是60
actimeo=n：将acregmin、acregmax、acdirmin、acdirmax设定为同一个数值，默认是没有启用。
retry=n：设定当网络传输出现故障的时候，尝试重新连接多少时间后不再尝试。默认的数值是10000 minutes
noac:关闭cache机制。

同时使用多个参数的方法：mount -t nfs -o timeo=3,udp,hard 192.168.0.30:/tmp /nfs
```
