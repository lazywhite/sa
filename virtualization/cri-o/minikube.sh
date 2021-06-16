version=v1.20.2

minikube start  --feature-gates=KubeletPodResources=true \
    --image-mirror-country cn  \
    --vm-driver=none \
    --container-runtime=cri-o \
    --extra-config=kubelet.cgroup-driver=systemd \
    --extra-config=kubelet.EnableCRI=true \
    --kubernetes-version=$version
    #--alsologtostderr -v=7
    #--network-plugin=kubenet
    #--extra-config=kubelet.image-service-endpoint="/path/to/sock" 默认跟container-runtime-endpoint一样
    # cgroup-driver必填, 否则报node "<>" not found
    #--extra-config=kubelet.PodCIDR=10.180.1.0/24
