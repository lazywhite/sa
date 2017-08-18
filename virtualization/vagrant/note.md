## Introduction
Vagrant - the command line utility for managing the lifecycle of virtual machines

## Usage
```
mkdir test
vagrant init test

vagrant up --no-provision
vagrant provision 
```

## build a customized box
```
vagrant init hashicorp/precise
vagrant up
vagrant ssh
    modify and clean 
vagrant package --output new.box
vagrant box add <name> /path/to/new.box

```
