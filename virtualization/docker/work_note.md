## 相关名词
- docker engine  
	底层管控container的引擎, 相当于docker daemon

- [docker machine](https://docs.docker.com/machine/)  
	可创建与ec2, openstack, vmware相兼容的容器的组件  


- [docker compose](https://docs.docker.com/compose/install/)  
	多容器组合运行套件

- [docker swarm](https://docs.docker.com/swarm/install-w-machine/)  
	容器集群和调度组件

- [kitematic](https://docs.docker.com/kitematic/)  
	桌面图形化管理工具

- [cockpit](http://cockpit-project.org/)  
	控制单台或多台物理机的web gui  
	


- [Kubernetes](http://kubernetes.io/v1.0/)  
	谷歌推出的容器集群管理平台  


## 软件版本 
- server: 10.10.1.2
- kernel: 3.10.0-229.4.2.el7.x86_64
- ip utility version: iproute2-ss130716(支持ip netns)
- docker version: 1.6.2
- cockpit version: 0.58  
[Cockpit](https://10.10.1.2:9090): 需要系统用户权限登录

## 涉及到的问题
- docker的后端存储问题: [详细介绍](http://developerblog.redhat.com/2014/09/30/overview-storage-scalability-docker/)  
目前通过修改/etc/sysconfig/docker-storage文件, 可将docker存储切换为"direct-lvm", 仅仅表示把container所需的和产生的文件放在某些lv里面而已
- 容器存储速率和存储大小问题: [介绍](http://dockone.io/article/216)  
iops是可以限制的, 存储的大小目前只能通过修改服务启动参数的方式限制. 且并未查阅到直接赋予某个容器如/dev/mapper/vg-lv设备的方法
- docker所支持的功能中, 除internal存储暂无明确证据不支持, 其他全部支持
- 可以通过docker file来定制各种各样的image, 我们只需要给不同的客户提供一个docker file 文本文件即可
- docker 提供python api, 可自行封装一层命令
- 可以图形化配置容器的存储和网络
- 可以连接容器的vnc



## 进行中
- 安装使用cockpit v0.9版本
- 网络部分探究使用




## allocate block device to container

	lvcreate -L 1G -n lv1 vg
	ll /dev/vg/lv1 # -> /dev/dm-8
	docker run -t -i --name test --cap=SYS_ADMIN --device=/dev/dm-8 centos:centos6 /bin/bash # -v /dev/mapper:/dev/mapper
	yum install -y e2fsprogs
	mkfs.ext4 /dev/dm-8
	#ln -s /dev/dm-8 /dev/mapper/vg-lv1
	mount -t ext4 /dev/dm-8 /mnt

注:  
1. 仅有--device, 可直接操作裸设备, 但无法mount, 需要配合--cap=SYS_ADMIN(兼容模式)    
2. mount会提示找不到/dev/mapper/vg-lv, 可手动创建链接, 或直接在docker run 指定挂载/dev/mapper目录    
3. docker run --privileged=true 特权模式有权限风险


## 成果
1. 宿主机/dev/vg/lv 映射为容器的/dev/sdx: -v /dev/dm-8:/dev/sde 
2. 容器时间同步 -v /etc/localtime:/etc/localtime
3. cockpit 0.9  [install_guid](https://github.com/cockpit-project/cockpit)  
增加了multi-server的控制和[kubernet](http://kubernetes.io/)集成
4. [docker run linux兼容模式学习](https://docs.docker.com/reference/run/)
5. [docker 技术学习](http://coolshell.cn/articles/17010.html)

## 问题
container配置的冷/热修改无法生效
centos7 container 无法运行systemd系统



## 工作内容
1. docker daemon监听设置(unix or host:port)
2. python模块requests_unixsocket 与 docker daemon的交互
3. [docker-compose](https://docs.docker.com/compose/) 学习使用 
4. [container-link](https://docs.docker.com/userguide/dockerlinks/) 学习使用
5. docker [restfull-api](https://docs.docker.com/reference/api/docker_remote_api_v1.19/) 
6. docker [data volume](http://docker-doc.readthedocs.org/zh_CN/latest/use/working_with_volumes.html) 学习使用
7. cockpit涉及到的nodejs学习  

## 问题
1. cockpit 如何做到container终端通过web进行交互
2. 搜集数据的daemon如何做到事件驱动而不是死循环



## daocloud mirror
docker -d --registry-mirror=http://daocloud.io
