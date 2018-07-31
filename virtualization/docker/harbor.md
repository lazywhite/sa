https://github.com/vmware/harbor/blob/master/docs/installation_guide.md

install docker
download  harbor-offline-v1.5.2.tgz
tar xf harbor-offline-v1.5.2.tgz
cd harbor
configure harbor.cfg
./install.sh

# 使用主机的80和443端口, 确保未被占用


client side
    docker login -u admin -p password 192.168.33.124
    docker tag submod/mnist-models:cnn  192.168.33.124/mnist-models:cnn
    docker push 192.168.33.124/mnist-models:cnn
