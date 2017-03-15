# versions
elasticsearch: 5.1.1
logstash: 5.1.1
kibana: 5.1.1

## 1.1 install elasticsearch
```
/etc/elasticsearch/elasticsearch.yml
    cluster.name: elk_test
    node.name: node1
    path.data: /es/data
    path.logs: /es/log
    network.host: 0.0.0.0
    http.port: 9200
    http.cors.enabled: true
    http.cors.allow-origin: "*"
```

```
/etc/security/limits.conf
    elasticsearch - nproc 65535
```    

