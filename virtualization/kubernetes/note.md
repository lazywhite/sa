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
	kubectl exec -it -n <ns> <pod> -c <container> -- env

pod命名规则: 只能由数字, 字母, 连字符组成, 连字符不能做开头

service类型
    ClusterIP
    NodePort
    LoadBalancer
    HeadLess(spec.clusterIP=None)

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

storageClass
    类似于openstack里面的flavor，本身仅仅记录对应的provisioner及一些默认参数

    apiVersion: storage.k8s.io/v1
    kind: StorageClass
    metadata:
      name: gold
      provisioner: kubernetes.io/cinder
      parameters:
        availability: nova

    设置默认storageClass
    1. 先移除默认sc的annotation
    kubectl patch storageclass <your-class-name> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
    2. 给新的sc添加annotation
    kubectl patch storageclass <your-class-name> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'



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


kubectl get filter

    kubectl get pods -l environment=production,tier=frontend
    kubectl get pods -l 'environment in (production),tier in (frontend)'
    kubectl get pods -l 'environment in (production, qa)'
    kubectl get pods -l 'environment,environment notin (frontend)'

    kubectl get --field-selector spec.nodeName=master1 pod 
    下列filed不支持
        spec.hostNetwork
        status.hostIP



nodeAffinity
    taint: node污点，不容忍此污点的pod不会被调度到此node
    toleration 只有容忍污点的pod, 才会被调度到相关node


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
    ping <svc>.<ns> 直接由pod进行响应
    nslookup  <svc>.<ns>直接返回所有endpoint ip(pod ip)

    服务端负载均衡：正常的service 下面挂的是Endpoints（podIP数组），通过iptables规则转发到实际的POD上
    客户端负载均衡：Headless Services不会分配ClusterIP,而是将Endpoints（即podIP数组）返回，也就将服务端的所有节点地址返回，让客户端自行要通过负载策略完成负载均衡。

    对无头 Service 并不会分配 Cluster IP，kube-proxy 不会处理它们， 而且平台也不会为它们进行负载均衡和路由。 DNS 如何实现自动配置，依赖于 Service 是否定义了选择算符。



kubectl get不显示列标题
    kubectl get --no-headers=true

所有资源的name不能包含大写字符


admission webhook
    validating
        验证提交的资源
    mutating
        改变提交的资源配置, 提供默认值，如resource limit，label，sidecar

admissionWebhook通过namespaceSelector来控制应用范围
ValidatingWebhookConfiguration, MutatingWebhookConfiguration是集群类型资源，没有namespace


webhook本质上是启动了一个https的web服务, kube-api-server会去POST数据, 因此validate，mutate configuration的配置文件
里面都需要配置一个CA, 这个CA可以用k8s已存在的CA，也可以通过cert-manager等自建一个CA


kubectl edit 无法更新status
	If the /status subresource is enabled, the following behaviors change:

	The main resource endpoint will ignore all changes in the status subpath. (note: it will not reject requests which try to change the status, following the existing semantics of other resources).


k8s对象的name， 只能由数字，字母，- 组成， 不能包含下划线

kubectl patch --type [json, merge, strategic]
    json: json patch
    merge: json merge patch
    strategic: strategic merge patch  // default

    strategic 可以指定patchStrategy(默认为replace，可以为merge, delete, delete from primitive list, retainKey), patchMergeKey
    With a JSON merge patch, if you want to update a list, you have to specify the entire new list. And the new list completely replaces the existing list.

    CR目前不支持策略合并



volume mountPath可以在线更改, 会重新生成pod

deployment无法使用volumeClaimTemplate


readinessProbe:

livenessProbe:
    exec:
        command:
        - cat
        - /tmp/healthy

    httpGet:  # 任何返回状态码>=200,<400认为成功，其它认为失败
        host: 默认为容器IP
        scheme: 默认为http,可为https
        path: /healthy
        port: 5000
        httpHeaders:
        - name: Custom-header
          value: "example"
    tcpSocket:
        port: 9090  # 如果能建立连接，就认为是成功的
    initialDelaySeconds: 30  # 开始检测前等待5秒, 非常重要!!
    periodSeconds: 5 # 每5秒检测一次
    successThreshold: 1
    failureThreashold: 3


startupProbe: # 优先级最高, 如果检测不通过，容器会被杀死，依赖重启策略进行重启
    failureThreashold: 10
    periodSeconds: 5 # 每5秒检测一次

restartPolicy: 适用于pod中的所有容器
    Always
    OnFailure: 退出状态码非0, job pod即为此policy
    Never

status:
    conditions:
    - type: PodScheduled  已被调度到某节点
      lastProbeTime: 上次探测的时间戳
      lastTransitionTime: 上次进行状态转换的时间戳
      reason: 机器可读，驼峰式文字，表示上次状态变化的原因
      message: 人类可读, 上次状态转换的详细信息
    - type: ContainersReady 所有容器已就绪
    - type: Intialized 所有init容器已成功执行
    - type: Ready 可以提供服务，并且被加到对应的负载均衡池内
    containerStatus:
    - name: exmpale
      ready: [true,false]
      containerID:
      image:
      imageID:
      restartCount:
      state:

容器状态只有三种[waiting,running,terminated], pod状态有[Pending,Running,Succeeded,Failed,Unknown]
如果status.phase为Succeeded, kubectl get结果显示为completed


kubectl drain 安全驱逐一个节点的所有pod

每个pod都会有一个google pause container, 用来初始化网络并设置ip地址，保证network namespace存在，挂载所有volume


bash添加自动补全
    yum -y install bash-completion
    echo 'source <(kubectl completion bash)' >>~/.bashrc
    或者
    kubectl completion bash >/etc/bash_completion.d/kubectl





kubectl delete --casecade=true //级联删除默认为true

CSI: container storage interface
CNI: container network interface
CRI: container runtime interface



provisioner工作原理
    启动controller，用来watch pvc
    获取pvc里面规定的storageClass
    获取storageClass里面的provisioner，如果是自己就执行Provision()
    

集群插件
    kubedns 
    dashboard
    EFK: 容器日志监控系统
    metric-server + prometheus: k8s集群资源监控系统
    harbor: 镜像仓库
    helm: 部署工具
    ingress(trafik): 外部访问内部service
    metalLB: 裸机集群load balancer, 类似于公有云的SLB
        对外暴露服务，需要NodePort，Ingress, 前者需要所有node都开启，后者只支持http协议，因此有了此项目
    CICD: jenkins+gitlab

    微服务: istio
    jaeger: 应用了opentracing标准的分布式系统(微服务)监控追踪工具, 类似的有pinpoint

自动水平扩容(horizental autoscale)
  Auto scale a deployment "foo", with the number of pods between 2 and 10, no target CPU utilization specified so a default autoscaling policy will be used:
    kubectl autoscale deployment foo --min=2 --max=10
  # Auto scale a replication controller "foo", with the number of pods between 1 and 5, target CPU utilization at 80%:
    kubectl autoscale rc foo --max=5 --cpu-percent=80

滚动发布(rolling update)
    kubectl set image deployment/test test=nginx:latest
    kubectl rollout status deployment/test
    kubectl rollout undo deployment/test
    kubectl rollout undo deployment/test --to-revision=<>


如果想将某个pod调度到指定node，可以使用下面的label
    kubernetes.io/hostname=node-name

scheduler
    集群中可以存在多个scheduler，通过spec.schedulerName来指定, 默认为default-scheduler

增强scheduler功能的方法有三种
    1. 直接修改源码，但后续升级upstream代码成本太高
    2. 自己实现一个scheduler，跟kube-scheduler跑在一起，但有分布式锁和缓存同步问题，并且有可能相互冲突
    3. 开发scheduler extender


scheduler extender
    Name(0
    Filter()
    Prioritize()
    Bind()
    ProcessPreemption() //抢占

    Prioritize webhook won't be triggered if it's running on an one-node cluster. 
    As it makes no sense to run priorities logic when there is only one candidate:


static pod
    Static Pods are managed directly by the kubelet daemon on a specific node, without the API server observing them.
    kubelet watches each static Pod (and restarts it if it fails)
    kubelet会把静态pod注册到集群(镜像pod)，kubectl get pod可以看到， 但是不能控制它
    kubelet --config=/var/lib/kubelet/confiig.yaml
        statidPodPath=/etc/kubernetes/manifests
    静态pod可以不是hostNetwork的

    

job如果没有产生pod就失败了，有可能是serviceAccount的问题
注意: 给job的pod规定serviceAccount，需要写在spec.template.spec.serviceAccountName, 而不是spec.serviceAccountName


如果configmap data有变更
    使用该 ConfigMap 挂载的 Env 不会同步更新
    使用该 ConfigMap 挂载的 Volume 中的数据需要一段时间（实测大概10秒）才能同步更新

	容器内不支持inotify, 容器内可以使用cronjob来使nginx, envoy hot reload

	inotifywait -r -m -e modify /var/log | 
	   while read path _ file; do 
		   echo $path$file modified
	   done

configmap value使用文件
    key: |
      "this is 
      a lone line"

网络
    存储网: Volume
    业务网: SLB
    管理网: VM

kubectl 删除 StatefulSet 会将其缩容为0，因此删除属于它的所有pods

pod启动
    pause容器
    initContainers
    containers


如果pod的env有改动， pod会被重建


serviceAccount全名: system:serviceaccount:kube-system:default


ServiceBroker
    ServiceClass
        ServicePlan
ServiceInstance

kubectl drain <node> --ignore-daemonsets --force --delete-local-data
```




### NetworkPolicy
```
https://godleon.github.io/blog/Kubernetes/k8s-Network-Policy-Overview/
NP的实现由各网络插件实现, 毕竟不同插件实现网络互联的方式不一样，NP只是定义了一个标准


Tips:
    networkpolicy无法应用到hostnetwork的pod

处理逻辑
    1. 默认情况下pod是非隔离的，接受任何来源流量
    2. 被某些networkpolicy的podSelector选中，进入隔离状态
    3. 如果某个pod被多个np匹配到，结果是它们的并集
    4. 为了允许两个pod之间通信，源pod的egress和目标pod的ingress都要允许
	5. 同一组被隔离的pod，默认是可以相互通信的
    6. ingress, egress都是白名单类型，不在规则内被deny

networkPolicy
    metadata:
        name:
        namespace: # 仅对同namespace下的pod生效

    spec:
        podSelector: # 若为{}则表示匹配所有pod
          matchLabels:
            key: value
        ingress:
        - from:
          - ipBlock:
            cidr: a.b.c.0/24
            except:
            - a.b.c.d/32
          - namespaceSelector: # 若为{}, 则匹配所有namespace
              matchLabels:
                key: value
          - podSelector:  # 只能匹配跟当前policy相同namespace下的pod
              matchLabels:
                key: value

          ports: # 留空则全部放行, 有内容则为白名单, 默认禁止
        egress:
        - to:
        policyType:
        - Ingress
        - Egress



样例

1. 默认拒绝所有入站流量
	apiVersion: networking.k8s.io/v1
	kind: NetworkPolicy
	metadata:
	  name: default-deny-ingress
	spec:
	  podSelector: {}
	  policyTypes:
	  - Ingress
2. 默认允许所有入站流量
	apiVersion: networking.k8s.io/v1
	kind: NetworkPolicy
	metadata:
	  name: default-allow-ingress
	spec:
	  podSelector: {}
      ingress: 
      - {}
	  policyTypes:
	  - Ingress
3. 默认拒绝所有出站流量
	apiVersion: networking.k8s.io/v1
	kind: NetworkPolicy
	metadata:
	  name: default-deny-egress
	spec:
	  podSelector: {}
	  policyTypes:
	  - Egress
4. 默认允许所有入站流量
	apiVersion: networking.k8s.io/v1
	kind: NetworkPolicy
	metadata:
	  name: default-allow-egress
	spec:
	  podSelector: {}
      egress: 
      - {}
	  policyTypes:
	  - Egress
```
