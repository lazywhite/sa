minikube-windows-amd64.exe start  --nodes 2 \
    --kubernetes-version=1.14.8 \
    --feature-gates=KubeletPodResources=true \
    --image-mirror-country cn  \
    --vm-driver=virtualbox \
    --no-vtx-check=true \
    --disable-driver-mounts=true # windows会自动挂载C:\Users到/c/Users

# 新增node
minikube-windows-amd64.exe add node


# 操作
minikube-windows-amd64.exe kubectl -- get node -o wide

# ssh
minikube-windows-amd64.exe ssh

# ip
minikube-windows-amd64.exe ip

# mount
minikube-windows-amd64.exe mount D:\:/host
