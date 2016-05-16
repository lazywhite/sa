必须用ssh-copy-id 部署公钥
ansible all -m ping
ansible <host> -m shell -a 
ansible localhost -m setup  [ -a 'filter=*network*' ]
ansible-doc module

# playbook

host_vars
role
    common
        files
        tasks
        defaults
        handlers
        templates


copy
    backup=yes
    owner
    group
    mode

ansible-playbook -i <inventory_file> -u <remote_user> <playbook.yml>
ansible-pull -o -C develop -d /var/projects/myrepo -i /var/projects/myrepo/hosts -U git://github.com/myrepo >> /var/log/ansible-pull.log 2>&1



ansible all -vvvv -u rock -i test.hosts -m git -a "repo=git@github.com:lazywhite/python.git dest=/Users/rock/python update=yes version=master force=yes"


## checkmode
ansible -C 

##  Galaxy
