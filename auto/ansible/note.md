## install latest ansible
```
$ sudo apt-get install software-properties-common
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt-get update
$ sudo apt-get install ansible

```
## Topic
```
必须用ssh-copy-id 部署公钥
ansible all -m ping
ansible <host> -m shell -a 
ansible localhost -m setup  [ -a 'filter=*network*' ]
ansible-doc module
```

# ansible command 

```
ansible -i <inventory_file> '<host pattern>' -m <module> -a <arguments>
ansible all -m copy -a "src=/root/m.deb dest=/root/m.deb"
ansible all -m shell -a "ls -al"
```
# playbook

## directory layout
```
group_vars
    group1
host_vars
    hostname1
roles
    common
        vars
        files
        tasks
        defaults
        handlers
        templates
        meta
site.yml
webserver.yml


copy
    backup=yes
    owner
    group
    mode

ansible-playbook -i <inventory_file> -u <remote_user> <playbook.yml>
ansible-pull -o -C develop -d /var/projects/myrepo -i /var/projects/myrepo/hosts -U git://github.com/myrepo >> /var/log/ansible-pull.log 2>&1



ansible all -vvvv -u rock -i test.hosts -m git -a "repo=git@github.com:lazywhite/python.git dest=/Users/rock/python update=yes version=master force=yes"

```
## checkmode
ansible -C 

##  Galaxy
third-party playbooks of ansible

## Ansible-container
>ansible container enable user to build docker images and orchestrate containers


## run as sudo user
ansible all -u admin -b -m ping

