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

## Usage
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
    ClusterIp
    NodePort
    LoadBalancer
    ExternalName (需要1.7版本以上, kube-dns支持)
rolling update
    在old pod的node上用新image启动new pod, 然后加入service, 删掉old pod, 最终达到全部替换
    update 是有版本的, 可以随时回退

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
```
