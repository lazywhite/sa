# Installation
```
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
yum -y install epel-release http://yum.theforeman.org/releases/1.8/el6/x86_64/foreman-release.rpm
yum -y install foreman-installer
```
# Setup 
config_file: /etc/foreman/foreman-installer-answers.yaml  
readme: /usr/share/foreman-installer/README.md
# Mode
All-in-one installation:

    --- 
    foreman: true
    puppet:
      server: true
    foreman_proxy: true

Just Foreman on its own:

    --- 
    foreman: true
    puppet: false
    foreman_proxy: false

Foreman and Foreman-Proxy:

    --- 
    foreman: true
    puppet: false
    foreman_proxy: true

Puppetmaster with Git and Proxy:

    --- 
    foreman: false
    puppet:
      server: true
      server_git_repo: true
    foreman_proxy: true

Foreman & proxy with a different username:

    --- 
    foreman:
      user: 'myforeman'
    puppet: false
    foreman_proxy:
      user: 'myproxy'



foreman-installer [-i]

/etc/init.d/foreman-proxy start
