## 进程绑定

```
taskset -pc 0,3,5-7 <pid>
taskset -c 0-7 stress -c 8 -t 600
```
