## 配置读写分离
1. 仅配置amoeba.xml-->queryRouter
2. 仅配置rule.xml 

## 分片

1. 水平分片
    rule.xml --> tableRule --> rule
2. 垂直分片
    rule.xml --> tableRule 


## 分片加读写分离
    rule.xml --> tableRule --> rule
