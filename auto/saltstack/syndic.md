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
    syndic_master: master

/etc/salt/minion
    id: syndic
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
## restart syndic service
```
/etc/init.d/salt-master restart
```

## topic
1. salt master看不到所有minion， 但可以直接操作任意minion
2. states file可以只保留在salt master
3. syndic file_roots, pillar_roots 必须与master保持一致
4. syndic 节点不会回应test.ping
5. syndic 节点会中继所有publications and events
