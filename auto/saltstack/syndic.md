## Installation
```
## master 节点
apt-get install salt-master
## syndic 节点
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
```
### 2. master side
```
order_masters: True
```
## Start service
```
# syndic side
/etc/init.d/salt-syndic start
/etc/init.d/salt-master start

# master side
/etc/init.d/salt-master start

```
## restart syndic service
```
/etc/init.d/salt-master restart
/etc/init.d/salt-syndic restart
```
## Usage
```
# master side
salt-key -a <syndic-id>

# syndic side
salt-key -A <minion-id>

# master side
salt 'minion-id' test.ping
```

## Topic
1. salt master看不到所有minion， 但可以直接操作任意minion
2. states 配置文件只需要放在salt master, syndic可以没有
3. syndic file_roots, pillar_roots 必须与master保持一致
4. syndic 节点不会回应test.ping
5. syndic 节点会中继所有publications and events
6. 文件不会从salt-master自动拉取, 每个syndic需要具备自己的file_roots配置, 可以使用http, git等fileserver_backend
