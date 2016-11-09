## Installation
```
apt-get install salt-syndic
```
## Configuration
### 1. syndic side
```
/etc/salt/master:
    file_roots:
      base:
        - /srv/salt
    pillar_roots:
      base:
        - /srv/salt/pillar
    syndic_master: salt-syndic
    id: corp-nat
```
### 2. master side
```
order_masters: True
```
## start service
```
/etc/init.d/salt-syndic start
## master side
salt-key -a <syndic-id>
```
