## Components
```
keystone: authentication
horizen: dashboard
nova: compute
magnum: container infrastructure management service
manila: shared file system service
aodh: telemetry alarm
ceilometer: telemetry data collect
neutron: networking
cinder: block storage
glance: image service
swift: object storage
heat: orchestration 
trove: database as a service

```
## Topic
1. neutron-l3 HA  
2. template injection  
3. win os template, virtIO driver  
4. spice replace vnc
5. neturon networking type: gre, vlan, vxlan


curl http://169.254.169.254/2009-04-04/meta-data/
curl http://169.254.169.254/openstack/latest/meta_data.json

注入ssh密钥
```
a) 创建密钥(ssh-keygen)

b) 添加密钥对

i. nova keypair-add --pub_key .ssh/id_rsa.pub mykey

c) 创建实例的时候注入密钥

i. nova boot --key_name mykey --image id_of_image --flavor 1 name_of_instance

Note: id_of_image可以通过nova image-list取得
```

注入文件
```
假如我要注入.vimrc这个文件到新创建的实例中，可以：

nova boot --file /root/.vimrc=/root/.vimrc --image id_of_image --flavor 1 name_of_instance

Note: 可以注入多个文件（最多5个），只要写多个--file <dst-path=src-path>

```
注入元数据
```
可以通过--meta给实例中传入键值对，注入后会写在/meta.js文件里，以类似python字典的方式存储在虚拟机的/meta.js文件中

nova boot --meta key2=value2 --meta key1=value1 --image id_of_image --flavor 1 name_of_instance

Cat /meta.js # 虚拟机中

｛＂key2": "value2", "key1": "value1"}

示例：
假如我们想让新创建的实例运行一个初始化脚本，但这个脚本会根据不用的需求有所变化，我们可以这样做

在创建镜像模板的时候在/etc/rc.local中加入

/opt/init.py

Init.py可以读取注入的元数据(meta.js)比如

｛"url": "http://example.com/init.sh"}

```
## Openstack 命令
```
openstack image list
openstack host list
openstack network list
openstack router list

```
## Tips
```
keystone adminurl 默认是内网地址, 没有暴露在外部, 需要配置反向代理
```
