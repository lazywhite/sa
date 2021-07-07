minikube-windows-amd64.exe start  --nodes 2 --disk-size=10g --memory=2g --kubernetes-version=1.14.8  --feature-gates=KubeletPodResources=true  --image-mirror-country cn   --vm-driver=virtualbox  --no-vtx-check=true  --network-plugin=cni  --cni=flannel  --disable-driver-mounts=true


# 执行
#.\cluster.ps1
