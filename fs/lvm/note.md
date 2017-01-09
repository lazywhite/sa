## Introduction
LVM can optionally use a central metadata cache, implemented through a daemon (lvmetad) and a udev rule.   
The metadata daemon has two main purposes: It improves performance of LVM commands and it allows udev to automatically   
activate logical volumes or entire volume groups as they become available to the system.  


## Usage
```
vgcreate vg1 /dev/vdb1
lvcreate -l +100%FREE  -n lv1 vg1
```
