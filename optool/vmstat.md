# 虚拟内存管理技术
## 1. paging
调页算法是将内存中最近不常使用的页面换到磁盘上，把活动页面保留在内存中供进程使用。
## 2. swapping
交换技术是将整个进程，而不是部分页面，全部交换到磁盘上

## vmstat各项信息
```
procs
    r: 队列进程数量
    b: 等待IO进程数量

memory
    swpd: 使用虚拟内存大小
    free: 
    buff: 用于缓冲内存大小
    cache: 用于缓存内存大小
    inact: inactive 非活跃内存大小
    active: 
swap
    si: swap in 
    so: swap out
io
    bi: block in 
    bo: block out 
system
    in: interrupt 每秒中断次数
    cs: context switch 
cpu
    us: user space
    sy: system space
    id: idle
    wa: io waiting
    st: 
```
## 常用命令
```
vmstat -d --unit m 
vmstat -a 1 
```
