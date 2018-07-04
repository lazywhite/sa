## 版本信息
```
kubeadm: v1.10.4
docker 1.13.1
setenforce 0

swapoff -a # 关闭交换分区
/etc/hosts 添加本机主机名解析

https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/
```

## 安装流程
# kubeadm reset 后, kubelet服务会死掉
```
yum -y install docker
cp daemon.json key.json /etc/docker
systemctl start docker
systemctl enable docker
docker info # check registry 

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
        http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

yum -y install kubelet kubectl kubeadm

systemctl enable kubelet 
systemctl start kubelet


cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

    

docker pull mirrorgooglecontainers/kube-scheduler-amd64:v1.10.4
docker pull mirrorgooglecontainers/kube-controller-manager-amd64:v1.10.4
docker pull mirrorgooglecontainers/kube-apiserver-amd64:v1.10.4
docker pull mirrorgooglecontainers/etcd-amd64:3.1.12

docker tag 6fffbea311f0 k8s.gcr.io/kube-scheduler-amd64:v1.10.4
docker tag 1a24f5586598 k8s.gcr.io/kube-controller-manager-amd64:v1.10.4
docker tag afdd56622af3 k8s.gcr.io/kube-apiserver-amd64:v1.10.4
docker tag 52920ad46f5b k8s.gcr.io/etcd-amd64:3.1.12


docker rmi docker.io/mirrorgooglecontainers/kube-apiserver-amd64:v1.10.4
docker rmi docker.io/mirrorgooglecontainers/kube-scheduler-amd64:v1.10.4
docker rmi docker.io/mirrorgooglecontainers/kube-controller-manager-amd64:v1.10.4
docker rmi docker.io/mirrorgooglecontainers/etcd-amd64:3.1.12

# 替换为国内镜像
cat /etc/kubernetes/manifests/*|grep -i image|sed 's/k8s.gcr.io/mirrorgooglecontainers/'|awk '{printf "docker pull %s\n", $2}'|bash
# 重命名为国外镜像
docker images|grep mirrorgooglecontainers|sed 's/docker.io\/mirrorgooglecontainers/k8s.gcr.io/' |awk '{printf "docker tag %s %s:%s\n", $3, $1,$2}'|bash
# 删除国内镜像
docker images |grep mirrorgooglecontainers|awk '{printf "docker rmi %s:%s\n", $1, $2}'|bash

kubeadm init \
--kubernetes-version=1.9.0 \
--pod-network-cidr=10.244.0.0/16 \
--apiserver-advertise-address=192.168.122.50 \
--ignore-preflight-errors=all
# 重复执行提示错误 --ignore-preflight-errors=all



# worker节点加入集群
kubeadm join --token <token> <master-ip>:<master-port> --discovery-token-ca-cert-hash sha256:<hash>
```




## 常见问题
```
unable to get URL “https://dl.k8s.io/release/stable-1.9.txt”: Get https://storage.googleapis.com/kubernetes-release/release/stable-1.9.txt: dial tcp 172.217.160.112:443: i/o timeout
通过指定--kubernetes-version来避免

[init] This might take a minute or longer if the control plane images have to be pulled.
提前准备好docker image
```
