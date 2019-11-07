ansible -i inventory all -u ansible -b -k -m shell -a ""
# 直接在所有主机执行本机的local.sh脚本， 无需事先copy过去
ansible -i inventory all -u ansible -b -k -m script -a "local.sh"
# 将所有机器的/etc/hosts传输到本机的./files文件夹
ansible -i inventory all -u ansible -b -k -m fetch -a "src=/etc/hosts dest=./files"

ansible -i inventory all -u ansible -b -k -m copy -a "src=a.sh dest=/tmp/a.sh mode=777 owner=root group=root backup=yes"

# 设置并发数, 默认为5
ansible -i inventory all -f 50 -m ping 
