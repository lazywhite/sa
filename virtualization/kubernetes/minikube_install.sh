#!/bin/bash

###### 执行要求  ###
# 1. sudo权限
# 2. cpu至少双核

version=v1.17.2

curl -Lo /bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$version/bin/linux/amd64/kubectl
curl -Lo /bin/minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x /bin/minikube
# socat for port-forward
apt install docker.io socat
minikube start  --image-mirror-country cn --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --registry-mirror=https://49ri251n.mirror.aliyuncs.com --kubernetes-version=$version  --vm-driver=none

kubectl get pods --all-namespaces
