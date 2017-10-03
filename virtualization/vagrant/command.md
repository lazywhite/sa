## Introduction
A command line utility for managing the lifecycle of virtual machines  

## Provider
1. virtualbox `default`
2. vmware
3. hyperv
4. docker  

   
```
(host)#export VAGRANT_DEFAULT_PROVIDER=vmware
```  

## Box  
```
$ vagrant box
Usage: vagrant box <subcommand> [<args>]

Available subcommands:
     add
     list
     outdated
     remove
     repackage
     update

For help on any individual subcommand run `vagrant box <subcommand> -h`
```  
## VagrantFile

```
$ cat Vagrantfile


# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.ssh.forward_agent = true
  config.ssh.username = "vagrant"
  config.vm.box = "dev"
#  config.vm.box_url = ""
  config.vm.network :private_network, ip: "192.168.222.5"
  config.vm.network "forwarded_port", guest: 9001, host: 9001
  config.vm.network "forwarded_port", guest: 19001, host: 19001
#  config.vm.synced_folder "bootstrap/cache", "/vagrant/bootstrap/cache",
#      owner: "vagrant",
#      group: "vagrant",
#      mount_options: ["dmode=777,fmode=777"]

  config.vm.provider "virtualbox" do |v|
    # access to all cpu cores on the host
    if host =~ /darwin/
      cpus = `sysctl -n hw.ncpu`.to_i
    elsif host =~ /linux/
      cpus = `nproc`.to_i
    else
      cpus = 2
    end
    v.customize ["modifyvm", :id, "--memory", 2048]
    v.customize ["modifyvm", :id, "--cpus", cpus]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
  config.vm.provision :ansible do |ansible|
    ansible.playbook = 'provisioning/warden.yml'
    ansible.inventory_path = 'provisioning/inventory/hosts.vagrant'
#    ansible.host_key_checking = false
    ansible.limit = '192.168.222.5'
    ansible.verbose = 'vvv'
  end
end
```

## Provision
1. ssh
2. ansible ```local|remote```
3. puppet
4. salt
5. chef  

## Synced Folder
```
1.directory of VagrantFile mapping to /vagrant   
2.config.vm.synced_folder "src/", "/srv/website"
```
## Multi-machine
```
Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: "echo Hello"

  config.vm.define "web" do |web|
    web.vm.box = "apache"
  end

  config.vm.define "db" do |db|
    db.vm.box = "mysql"
  end
end
```
## Useful command
```
$ vagrant help
Usage: vagrant [options] <command> [<args>]

    -v, --version                    Print the version and exit.
    -h, --help                       Print this help.

Common commands:
     box             manages boxes: installation, removal, etc.
     connect         connect to a remotely shared Vagrant environment
     destroy         stops and deletes all traces of the vagrant machine
     global-status   outputs status Vagrant environments for this user
     halt            stops the vagrant machine
     help            shows the help for a subcommand
     init            initializes a new Vagrant environment by creating a Vagrantfile
     login           log in to HashiCorp's Atlas
     package         packages a running vagrant environment into a box
     plugin          manages plugins: install, uninstall, update, etc.
     port            displays information about guest port mappings
     powershell      connects to machine via powershell remoting
     provision       provisions the vagrant machine
     push            deploys code in this environment to a configured destination
     rdp             connects to machine via RDP
     reload          restarts vagrant machine, loads new Vagrantfile configuration
     resume          resume a suspended vagrant machine
     share           share your Vagrant environment with anyone in the world
     snapshot        manages snapshots: saving, restoring, etc.
     ssh             connects to machine via SSH
     ssh-config      outputs OpenSSH valid configuration to connect to the machine
     status          outputs status of the vagrant machine
     suspend         suspends the machine
     up              starts and provisions the vagrant environment
     version         prints current and latest Vagrant version
```
