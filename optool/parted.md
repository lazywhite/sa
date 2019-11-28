yum -y install parted
创建大于2T分区

parted /dev/sdb

>p # print current label

>mklabel gpt
>mkpart primary 0% 100%

>q

