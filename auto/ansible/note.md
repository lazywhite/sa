## Install
```
$ sudo apt-get install software-properties-common
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt-get update
$ sudo apt-get install ansible

```

## Keyword
```
facter
    自定义facter
Galaxy
    third-party playbooks roles of ansible  

Ansible-container
    ansible container enable user to build docker images and orchestrate containers

playbook
    play
        task
        handler
```
## Command 

```
ansible -i <inventory_file> '<host pattern>' -m <module> -a <arguments>
ansible all -m copy -a "src=/root/m.deb dest=/root/m.deb"
ansible all -m shell -a "ls -al"

ansible -all -f <并发数> 
```

## Playbook

```
inventories
    production
        group_vars
            group1 # 群组变量
        host_vars
            hostname1 # 主机变量
        hosts # 主机及组的配置文件
roles
    common
        vars
            main.yml # role变量
        files
            foo.sh
            bar.tar.gz
        tasks
            main.yml
        defaults
            main.yml #默认变量
        handlers
            main.yml
        templates
            foo.j2
        meta
            main.yml #role 依赖
        library # custom module
        module_utils #custom module util

site.yml  # master playbook
webserver.yml # 针对webserver的playbook

ansible-playbook -i <inventory_file> -u <remote_user> <playbook.yml>
ansible-pull -o -C develop -d /var/projects/myrepo -i /var/projects/myrepo/hosts -U git://github.com/myrepo >> /var/log/ansible-pull.log 2>&1

ansible all -vvvv -u rock -i test.hosts -m git -a "repo=git@github.com:lazywhite/python.git dest=/Users/rock/python update=yes version=master force=yes"
```
## Topic
```
必须用ssh-copy-id 部署公钥
ansible all -m ping
ansible <host> -m shell -a 
ansible localhost -m setup  [ -a 'filter=*network*' ]
ansible-doc module

ansible-playbook|ansible  -C  # check mode , commands module会被跳过
ansible-playbook|ansible  -C  -D # show difference of file change

handler会在最后执行
ansible all -a /bin/date # -m 默认为commands, 可以省略

inventory file 
    /etc/ansible/hosts

run as sudo user
    ansible all -u admin -b -m ping

jinja2 template {{}}要用"", 防止跟yaml的字典语法冲突
```

