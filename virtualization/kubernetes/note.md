## Component
```

master
    api
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

node
    deployment
        pod
            container
    service

CLI
    kubeadmin: 管理集群节点
    kubectl: 管理pod, service
    minikube: 启动单机k8s

object
    metadata
    spec: desired state
    status: actual state
```

## Minicube Usage
```
minikube start --vm-driver=kvm2
minikube delete
minikube ip


kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')

kubectl version
kubectl api-versions
kubectl get nodes
kubectl cluster-info
kubectl get deployment

# start deployment
kubectl run nginx --image=nginx:latest --port=80


# start service
kubectl expose deployment/nginx --type="NodePort" --port 80


# start proxy, 仅在minicube中使用
kubectl proxy

# check service
kubectl get pods; export POD_NAME=nginx-6bfb654d7c-ws2nv
curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/proxy/

# delete service
kubectl delete service -l run=kubernetes-bootcamp

# execute command of pod
kubectl exec -ti $POD_NAME curl localhost:8080

# scale deployment
kubectl scale deployments/kubernetes-bootcamp --replicas=4
kubectl get pods -o wide

kubectl describe service/kubernetes-bootcamp

# update
kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v2
# 确认升级
kubectl rollout status deployments/kubernetes-bootcamp
# 回退
kubectl rollout undo deployments/kubernetes-bootcamp


deployment.yaml
    apiVersion
    kind:
        Deployment
        Service
    metadata
        name
        uid
        namespace
kubectl create -f /path/to/deployment.yaml --record

```

## Tips
```
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


kubectl
    create
    run
    replace
    delete
    apply
    scale
    autoscale
    annotate
    label
    set
    edit
    patch
    get <nodes|pod|service|deployment>
    describe <pod|service|deployment|replicaset>
    logs <pod>
    exec
    top

App
    stateless
    stateful


```


```
# create deployment
kubectl run hello-world --replicas=5 --labels="run=load-balancer-example" --image=gcr.io/google-samples/node-hello:1.0  --port=8080
kubectl get deployment hello-world
kubectl describe deployments hello-world
kubectl get replicasets
kubectl describe replicasets hello-world-5b446dd74b
# create service
#kubectl expose deployment hello-world --type=NodePort --name=my-service --port=88 --target-port=8080
# curl <cluster-ip>:<port> ; curl <node-ip>:<node-port>

kubectl expose deployment hello-world --type=LoadBalancer --name=my-service
kubectl get services my-service
kubectl describe services my-service
# clean up
kubectl delete services my-service
kubectl delete deployment hello-world

```
## Cronjob



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


使用rbd pv

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


```

