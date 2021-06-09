#!/bin/bash
###### 执行要求  ###
# 1. sudo权限
# 2. cpu至少双核

version=v1.14.8

minikube start  --feature-gates=KubeletPodResources=true \
    --image-mirror-country cn  \
    --vm-driver=none \
    --kubernetes-version=$version \
    --network-plugin=cni

#--image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers //default
#--registry-mirror=https://49ri251n.mirror.aliyuncs.com  //default
#--extra-config="kubelet.node-ip=192.168.56.101" //specify node ip
