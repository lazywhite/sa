## command
```
salt-master -l debug ## run salt-master in foreground
salt-run state.event pretty=True  ## list received event
salt-call event.send 'demo' '{orchestrate: refresh, act: accept, result: true}'

demo    {
    "_stamp": "2017-04-11T09:37:16.364448",
    "cmd": "_minion_event",
    "data": {
        "__pub_fun": "event.send",
        "__pub_jid": "20170411093716349570",
        "__pub_pid": 14856,
        "__pub_tgt": "salt-call",
        "act": "accept",   # data['data']['act'] 
        "orchestrate": "refresh",
        "result": true
    },
    "id": "2ec8cdb49718",  # data['id']
    "tag": "demo"
}

```

## conf
```
reactor:
  - 'salt/key':
      - /srv/reactor/discovery.sls
```
