## Introduction
pachyderm是一个数据处理框架, 可以用来执行机器学习, AI, 大数据等任务. 
[技术术语](https://docs.pachyderm.com/latest/concepts)
repo: versioned data, 类似于git repo
pipeline: a workflow to perform data transformation


## Installation
```
# 需要一个running k8s cluster

curl -o /tmp/pachctl.tar.gz -L https://github.com/pachyderm/pachyderm/releases/download/v1.10.0/pachctl_1.10.0_linux_amd64.tar.gz && tar -xvf /tmp/pachctl.tar.gz -C /tmp && sudo cp /tmp/pachctl_1.10.0_linux_amd64/pachctl /usr/local/bin


# 查看client版本
pachctl version --client-only 

# 查看安装详情
pachctl deploy local --dry-run > pachyderm.json
# 安装(需要docker pull images)
pachctl deploy local 

# 有如下结果证明安装成功
# kubect get pods
NAME                     READY     STATUS    RESTARTS   AGE
dash-6c9dc97d9c-vb972    2/2       Running   0          6m
etcd-7dbb489f44-9v5jj    1/1       Running   0          6m
pachd-6c878bbc4c-f2h2c   1/1       Running   0          6m

```

## Tutorial

this section base on [official tutorial](https://docs.pachyderm.com/latest/getting_started/beginner_tutorial/)

```
## 1. prepare data 
# create a repo
pachctl create repo images

# view created repo
pachctl list repo

# upload a file to master branch of images repo with an atomic commit
pachctl put file images@master:liberty.png -f http://imgur.com/46Q8nDz.png

# view commits of images repo
pachctl list commit images

# view files of commit
pachctl list file images@master

# download a file
pachctl get file images@master:liberty.png > liberty.png

## 2. process data by openCV
# create a pipeline to process images repo, wait for docker pull image
pachctl create pipeline -f https://raw.githubusercontent.com/pachyderm/pachyderm/master/examples/opencv/edges.json

# check if  pipeline pod is running
kubectl get pod

# if pipeline pod state is running, check pipeline and job
pachctl list pipeline
pachctl list job
 
# if job finished, it will output data to a repo same name with pipeline
pachctl list file edges@master

# download processed image
pachctl get file edges@master:liberty.png > a1.png

# read output image
(macos) open a1.png
```
