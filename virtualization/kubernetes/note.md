## Component
```
master
    apiserver
    etcd
    scheduler
    kube controller manager
        node controller
        replica controller
        endpoint controller
        auth&token controller
    cloud controller manager

node
    kubelet
    kube-proxy
    container runtime
        docker
        rkt
addon
    DNS
    Web-UI
    resource monitoring
    logging


CLI
    kubeadmin: 管理集群节点
    kubectl: 管理pod, service
    minikube: 启动单机k8s

object
    metadata
    spec: desired state
    status: actual state

Access modes
	ReadWriteOnce – the volume can be mounted as read-write by a single node(RWO)
	ReadOnlyMany – the volume can be mounted read-only by many nodes(ROX)
	ReadWriteMany – the volume can be mounted as read-write by many nodes(RWX)

Reclaim Policy
 	Retain: 保留volume
	Recycle (只有本地盘和nfs支持数据盘Recycle 擦除回收)
	Delete: 删除volume
```




## 使用rbd pv
```

(一) 直接使用
在k8集群所有节点安装ceph-common包, 注意版本跟ceph集群保持一致
1. ceph-deploy  --username root install --no-adjust-repos master1
2. ceph-deploy admin master1 [node1 ...]
3. 手动创建rbd image
   rbd create ssd-pool/foo --size 4096M --image-feature layering
4. rbd.yaml

   apiVersion: v1
   kind: Pod
   metadata:
     name: rbd
   spec:
     containers:
       - image: busybox
         name: rbd-rw
         command: ["sleep", "60000"]
         volumeMounts:
         - name: rbdpd
           mountPath: /mnt/rbd
     volumes:
       - name: rbdpd
         rbd:
           monitors:
           - '192.168.56.59:6789'
           pool: ssd-pool
           image: foo
           fsType: xfs
           readOnly: false
           user: admin
           keyring: /etc/ceph/ceph.client.admin.keyring
           imageformat: "2"
           imagefeatures: "layering"

5. kubectl create -f rbd.yaml --validate=false


(二) 使用PV + PVC
   注意: 删除pv前要删除相关的pvc
   使用前仍需手动创建rbd image
   https://github.com/kubernetes/examples/tree/master/staging/volumes/rbd

(三) StorageClass + PVC (动态)
https://blog.csdn.net/aixiaoyang168/article/details/79120095
1. 生成kube secret
   ceph auth get-key client.admin |base64   # 获取ceph admin用户的key, 并替换 ceph-secret-admin.yaml中字段
   kubectl create -f ceph-secret-admin.yaml
2. 生成storageclass
3. 生成pvc
4. 生成pod


StorageClass如果有annotation标为default, 则pvc无需写storageclass

```



## Tips
```
yum -y install bridge-utils
自动删除
    kubectl run centos --image=centos --rm -it
指定pod运行的node
    kubectl label nodes 172.31.23.236 node=node3

    nginx.yml
        apiVersion: v1
        kind: Pod
        metadata:
          name: nginx
          labels:
            env: test
        spec:
          containers:
          - name: nginx
            image: nginx
            imagePullPolicy: IfNotPresent
          nodeSelector:
            node: node3
    kubectl create -f nginx.yml

查看某个pod配置
     kubectl get pod nginx-768979984b-8vrq5 -o yaml
编辑某个pod配置
     kubectl edit pod nginx-768979984b-8vrq5

kube-proxy优先使用ipvs, 否则使用iptables

查看pod的环境变量
	kubectl exec -it -n <ns> <pod> -- env

pod命名规则: 只能由数字, 字母, 连字符组成, 连字符不能做开头
service的cluster-ip可以手动指定, 也可以设置为空

如果pod有对应的service, 则pod自动具备以下环境变量
    <SERVICE_NAME>_SERVICE_HOST
    <SERVICE_NAME>_SERVICE_PORT

DNS
    service
        <service_name>.<namespace>.svc.cluster.local
    pod 
        <1-2-3-4>.<namespace>.pod.cluster.local  -> 1.2.3.4
        如果有一个headless service并且一个pod的subdomain等于service的metadata.name
        则此pod具有一个<hostname>.<subdomain>.<namespace>.svc.cluster.local的FQDN

    coredns容器创建时会使用host的/etc/resolv.conf, 下列命令重新生成
        kubectl delete -f manifests/coredns/coredns.yaml
        kubectl apply -f manifests/coredns/coredns.yaml

    测试(不要使用busybox)
        kubectl run b1 -it --rm --image=alpine /bin/sh
        nslookup


设置资源上限    
    kubectl run nginx1 --image=nginx --port=80 --expose --limits='cpu=500m,memory=8Mi'
    kubectl run --rm -it load-generator --image=busybox /bin/sh

kubelet edit ing test # 修改后直接生效
kubectl replace -f # 更换object

无法删除pod, 先get node查看node是否ready
pvc区分namespace, storageClass不区分

cockpit监控工具集成
    ansible -i hosts  all -m shell -a 'yum -y install cockpit cockpit-docker cockpit-kubernetes'
    ansible -i hosts  all -m shell -a 'systemctl start cockpit'
    ansible -i hosts  all -m shell -a 'systemctl enable cockpit'

    node1:9090 #使用系统用户登录

使用NFS, 所有节点安装nfs-utils

node自带的label, 可以供nodeSelector使用
    kubernetes.io/hostname
    failure-domain.beta.kubernetes.io/zone
    failure-domain.beta.kubernetes.io/region
    beta.kubernetes.io/instance-type
    beta.kubernetes.io/os
    beta.kubernetes.io/arch


获取dashboard admin token
    kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')

pod status: NodeLost
    systemctl restart kubelet

运行时与配置做比对和patch
    kubectl diff -R -f configs/
    kubectl apply -R -f configs/

动态调整
    kubectl scale deployment/nginx-deployment --replicas=2

强制重启某个pod
    kubectl get pod PODNAME -n NAMESPACE -o yaml | kubectl replace --force -f -

获取某个ns下所有资源
    kubectl -n <name> get all

label
    kubectl describe node <node> # view label
    kubectl label node <node> name=value [--overwrite] # 赋值
    kubectl label node <node> name-   # 删除某个label

role
    kubectl label node <node>  node-role.kubernetes.io/worker=

kubectl explain Deployment.spec

taint
    kubectl taint node  <node> key1=value1:NoSchedule  # 新增
    kubectl taint node  <node> key1:NoSchedule-  # 删除

endpoint
　　Endpoints是实现实际服务的端点集合
    service配置selector，endpoint controller才会自动创建对应的endpoint对象；否则，不会生成endpoint对象.
    k8s集群中创建一个名为hello的service，就会生成一个同名的endpoint对象，ENDPOINTS就是service关联的pod的ip地址和端口


NetworkPolicy
    https://godleon.github.io/blog/Kubernetes/k8s-Network-Policy-Overview/


Secret
	data:
	stringData

secret data字段value需要使用base64编码，挂载为volume, 或secretKeyRef, secretRef后会自动解码
	echo -n "hello"|base64
	echo -n "aGVsbG8=" |base64 -d

pod是一组container，共享volume和network, 启动时由initContainer进行初始化
env
	containers:
	- name: test
	  envFrom:
	  - secretRef:
	      name: <>  # secret data里面的值，会被自动base64 -d
      - configMapRef:
	    name: <>
      env:
	  - name: USER_NAME
	    valueFrom:
  	      secretKeyRef:
		    name: <>
			key: <>
      - name: USER_PASSWD
	    valueFrom:
		  configMapKeyRef:
		    name: <>
			key: <>
		  
kubectl -n argo port-forward --address 0.0.0.0 deployment/argo-server 2746:2746
	需要系统安装socat
	不指定address, 仅监听在127.0.0.1


pod有生命周期, 一个pod内的所有容器共享网络和存储
pod需要service才能暴露给外部
service具备internal load-balancer, 可以给exposed deployment提供负载均衡
service expose type
    ClusterIp: default, 在集群内部可以使用的ip
    NodePort: 在集群所有节点上开放同一个端口,手动指定--nodeport, 自动生成--service-node-port-range
    LoadBalancer: 需要依赖云服务提供商
    ExternalName (需要1.7版本以上, kube-dns支持)
rolling update
    在old pod的node上用新image启动new pod, 然后加入service, 删掉old pod, 最终达到全部替换
    update 是有版本的, 可以随时回退

service的selector需要谨慎定义, 错误会导致cluster-ip:port不可达的问题

kubectl rollout
    history     View rollout history
    pause       Mark the provided resource as paused
    resume      Resume a paused resource
    status      Show the status of the rollout
    undo        Undo a previous rollout

每个object会有系统分配的UID, 同类object不能有相同name的object
namespace: virtual cluster, resource quota, access control

kubectl namespace
    kubectl get namespaces
    kubectl --namespace=<insert-namespace-name-here> run nginx --image=nginx
    kubectl --namespace=<insert-namespace-name-here> get pods


Label and Selector
    label are key/value pair attached to objects, 用来选择object

Annotation
    不是用来选择object, 是放在metadata里面的注释信息

App
    stateless
    stateful
    

Cronjob


每个pod都需要一个serviceAccount, 不指定的话， 默认使用pod所在namespace的default用户，并且会自动挂载为volume
通过Role, ClusterRole来规定权限, 再通过RoleBinding, ClusterRoleBinding连接serviceAccount


kubectl get  custom field
    kubectl get pods  -o=custom-columns='Name:metadata.name,Node:spec.nodeName'

	# 集群中运行着的所有镜像
	kubectl get pods -A -o=custom-columns='DATA:spec.containers[*].image'

	 # 除 "k8s.gcr.io/coredns:1.6.2" 之外的所有镜像
	kubectl get pods -A -o=custom-columns='DATA:spec.containers[?(@.image!="k8s.gcr.io/coredns:1.6.2")].image'

	# 输出 metadata 下面的所有字段，无论 Pod 名字为何
	kubectl get pods -A -o=custom-columns='DATA:metadata.*'

    kubectl get pods <pod-name> -o custom-columns-file=template.txt

    where the template.txt file contains:

    NAME          RSRC
    metadata.name metadata.resourceVersion


kubectl get pod -A -o=custom-columns='Namespace:metadata.namespace,Name:metadata.name,Tolerations:spec.tolerations'|grep -e 'map\[effect:NoSchedule operator:Exists\]' -e 'map\[operator:Exists\]' -e "node.kubernetes.io/unschedulable"|awk '{printf("%s/%s\n",$1,$2)}'




taint和toleration
    只有容忍污点的pod, 才会被node运行
    https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/


给pod指定运行的node

    spec.nodeName 直接指定运行到哪个节点
    spec.nodeSelector
        1. 给node打label
        2. pod使用label
        https://www.cnblogs.com/tylerzhou/p/11023136.html


service cidr
    查看
        kubectl cluster-info dump|grep -i 'service-cluster-ip-range'
    kube-api-server指定如下参数
    --service-cluster-ip-range=10.254.0.0/16
    --service-node-port-range=30000-32767

指定pod cidr

--pod-network-cidr string
指明 pod 网络可以使用的 IP 地址段。如果设置了这个参数，控制平面将会为每一个节点自动分配 CIDRs。
--service-cidr string     默认值："10.96.0.0/12"
为服务的虚拟 IP 地址另外指定 IP 地址段
--service-dns-domain string     默认值："cluster.local"

pod访问service
    同namespace，直接ping serviceName
    跨namespace，ping serviceName.serviceNamespace
    
pod的hostname，dns

手动配置pod dns解析
    pod.spec.dnsConfig
        namservers, 最多配置3个
        searches, 最多配置3个


service的实际实现
    iptables
        使用statistics模块的random模式进行负载均衡
        使用recent模块进行会话保持
            sessionAffinity: ClientIP
            sessionAffinityConfig:
              clientIP:
                timeoutSeconds: 10800
    ipvs

headless service 作用
    nslookup  <svc>.<ns>直接返回所有endpoint ip(pod ip)

    服务端负载均衡：正常的service 下面挂的是Endpoints（podIP数组），通过iptables规则转发到实际的POD上
    客户端负载均衡：Headless Services不会分配ClusterIP,而是将Endpoints（即podIP数组）返回，也就将服务端的所有节点地址返回，让客户端自行要通过负载策略完成负载均衡。



kubectl get不显示列标题
    kubectl get --no-headers=true

所有资源的name不能包含大写字符
```
