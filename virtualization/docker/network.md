## container 网络模式
```
docker run -net "<mode>"
1. none:  container内部仅有loopback网卡
2. bridge: 默认选项, 将会创建一堆veth, 一端桥在"docker0", 另一端在container内部"eth0"
3. host: container将共享host的网络堆栈信息, 不设置隔离
4. container:<cid|name>: 将共享另一个container的网络信息

```
