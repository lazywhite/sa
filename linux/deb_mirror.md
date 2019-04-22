```
apt-get install apt-mirror
mkdir /mirrors
```

### /etc/apt/mirror.list
```
set base_path    /mirrors
#
# set mirror_path  $base_path/mirror
# set skel_path    $base_path/skel
# set var_path     $base_path/var
# set cleanscript $var_path/clean.sh
# set defaultarch  <running host architecture>
# set postmirror_script $var_path/postmirror.sh
# set run_postmirror 0
set nthreads     20
set _tilde 0
#
############# end config ##############

deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu trusty main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu trusty-security main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu trusty-updates main restricted universe multiverse
#deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu trusty-proposed main restricted universe multiverse
#deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu trusty-backports main restricted universe multiverse

deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu trusty main restricted universe multiverse
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu trusty-security main restricted universe multiverse
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu trusty-updates main restricted universe multiverse
#deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu trusty-proposed main restricted universe multiverse
#deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu trusty-backports main restricted universe multiverse

deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security multiverse

clean http://mirrors.tuna.tsinghua.edu.cn/ubuntu

```
```
# apt-mirror #进行同步, 用screen在后台跑, 可随时中断, 可添加cronjob
# ln -s /mirrors/mirror/mirrors.tuna.tsinghua.edu.cn/ubuntu <webroot>/ubuntu # 必须使用绝对路径
```

### repo配置
```
14.04
    deb [arch=amd64] http://192.168.1.10/ubuntu trusty main restricted universe multiverse
    deb [arch=amd64] http://192.168.1.10/ubuntu trusty-security main restricted universe multiverse
    deb [arch=amd64] http://192.168.1.10/ubuntu trusty-updates main restricted universe multiverse
    #deb [arch=amd64] http://192.168.1.10/ubuntu trusty-proposed main restricted universe multiverse
    #deb [arch=amd64] http://192.168.1.10/ubuntu trusty-backports main restricted universe multiverse

    deb-src [arch=amd64] http://192.168.1.10/ubuntu trusty main restricted universe multiverse
    deb-src [arch=amd64] http://192.168.1.10/ubuntu trusty-security main restricted universe multiverse
    deb-src [arch=amd64] http://192.168.1.10/ubuntu trusty-updates main restricted universe multiverse
    #deb-src [arch=amd64] http://192.168.1.10/ubuntu trusty-proposed main restricted universe multiverse
    #deb-src [arch=amd64] http://192.168.1.10/ubuntu trusty-backports main restricted universe multiverse

16.04
    deb [arch=amd64] http://192.168.1.10/ubuntu/ xenial main restricted
    deb [arch=amd64] http://192.168.1.10/ubuntu/ xenial-updates main restricted
    deb [arch=amd64] http://192.168.1.10/ubuntu/ xenial universe
    deb [arch=amd64] http://192.168.1.10/ubuntu/ xenial-updates universe
    deb [arch=amd64] http://192.168.1.10/ubuntu/ xenial multiverse
    deb [arch=amd64] http://192.168.1.10/ubuntu/ xenial-updates multiverse
    deb [arch=amd64] http://192.168.1.10/ubuntu/ xenial-backports main restricted universe multiverse
    deb [arch=amd64] http://192.168.1.10/ubuntu/ xenial-security main restricted
    deb [arch=amd64] http://192.168.1.10/ubuntu/ xenial-security universe
    deb [arch=amd64] http://192.168.1.10/ubuntu/ xenial-security multiverse

```
