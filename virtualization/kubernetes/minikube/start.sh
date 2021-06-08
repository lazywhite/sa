#!/bin/bash
###### 执行要求  ###
# 1. sudo权限
# 2. cpu至少双核


#version=v1.17.3
version=v1.14.8

#BIN_DIR=~/bin
#KUBECTL=${BIN_DIR}/kubectl
#MINIKUBE=${BIN_DIR}/minikube

#mkdir -p ${BIN_DIR}

make_installed(){
dpkg -L $1 >/dev/null
if [ $? -ne 0 ];then
sudo apt install $1
fi
}

# socat for port-forward
#make_installed socat
#make_installed liblz4-tool

#sudo apt install docker.io

#if [ ! -f ${KUBECTL} ];then
#curl -Lo ${KUBECTL} https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
#chmod a+x ${KUBECTL}
#fi

#if [ ! -f ${MINIKUBE} ];then
#curl -Lo ${MINIKUBE} https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
#chmod a+x ${MINIKUBE}
#fi

#sudo ${MINIKUBE} start  --feature-gates=KubeletPodResources=true --image-mirror-country cn  --vm-driver=none --kubernetes-version=$version  #--network-plugin=cni #--extra-config="kubeadm.pod-network-cidr=10.224.0.0/16"

minikube start  --feature-gates=KubeletPodResources=true --image-mirror-country cn  --vm-driver=none --kubernetes-version=$version --extra-config="kubelet.node-ip=192.168.56.101"

#sudo ${MINIKUBE} start  --feature-gates=KubeletPodResources=true --image-mirror-country cn --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --registry-mirror=https://49ri251n.mirror.aliyuncs.com  --vm-driver=none --kubernetes-version=$version  #--network-plugin=cni #--extra-config="kubeadm.pod-network-cidr=10.224.0.0/16"
#sudo ${MINIKUBE} start  --feature-gates=KubeletPodResources=true --image-mirror-country cn --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --registry-mirror=https://49ri251n.mirror.aliyuncs.com --kubernetes-version=$version  --vm-driver=none

