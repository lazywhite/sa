## Installation
### Requirement
```
os: RHEL-6.6
sybase: SAP Adaptive Server Enterprise 16.0 SP02

```

### Dependency
```
openmotif-devel
libXp-devel
libXt-devel
libXtst-devel
libXi-devel
libXmu-devel
libXext-devel
libSM-devel
libICE-devel
libX11-devel
glibc.i686
glibc.x86_64
```

### Install
```
./setup.bin -i console

```
### Usage
```
source /opt/sap/SYBASE.sh
startserver -f /opt/sap/ASE-16_0/install/RUN_SYBASE

isql -Usa -P<sybase admin password> -S<server_name>


sp_tables;go  --> show tables
SELECT name FROM sysobjects WHERE type = 'U';

```

### Create database
```
## Notice: disk device size in Mb
disk init
   name="JASONWOOD",
   physname="/opt/sap/data/jasonwood.dat",
   size="225280m"
go


disk init 
   name="JASONWOOD_LOG",
   physname="/opt/sap/data/jasonwood_log.dat",
   size="100m"
go


use master
go

create database jasonwood
   on JASONWOOD="225280m"
   log on JASONWOOD_LOG="100m"
go



```

## Drop database
```
drop database test
go
sp_dropdevice  'JASONWOOD'
go
sp_dropdevice 'JASONWOOD_LOG' go

rm -f /opt/sap/data/jasonwood.dat  /opt/sap/data/jasonwood_log.dat
```

## Set default charset 
```
source /opt/sap/SYBASE.SH
cd /opt/sap/charset/cp936
charset -Usa -Psybase -SSYBASE binary.srt cp936 # install cp936 charset
isql64 -Usa -Psybase -SSYBASE
1> select name, id from syscharsets
2> go

cp936 171

1> sp_configure 'default character set id', 171
2> go
## after this should reboot database daemon "twice"
1> shutdown
2> go

# cd /opt/sap/ASE-16_0/install
# startserver -f RUN_SYBASE


## check default charset
1> sp_helpsort
2> go
``` 


## get help information
```
1> sp_helpserver
2> go

2> sp_helpdb
2> go
```

## set sybase server bind ip
/opt/sap/interfaces  
>sybase is hostname    

/etc/hosts      
>192.168.11.73  sybase  
      
```
SYBASE
        master tcp ether sybase 5000
        query tcp ether sybase 5000


SYBASE_BS
        master tcp ether sybase 5001
        query tcp ether sybase 5001


SYBASE_XP
        master tcp ether sybase 5002
        query tcp ether sybase 5002


SYBASE_JSAGENT
        master tcp ether sybase 4900
        query tcp ether sybase 4900
```

