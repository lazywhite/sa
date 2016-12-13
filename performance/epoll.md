## Documentation
[doc01](http://blog.csdn.net/tennysonsky/article/details/45745887)   
[doc02](http://www.smithfox.com/?e=191)  

## Introduction

I/O 多路复用技术是为了解决进程或线程阻塞到某个 I/O 系统调用而出现的技术，使进程不阻塞于某个特定的 I/O 系统调用。  
select(), poll(), epoll()都是I/O多路复用技术的一种,  但select()，poll()，epoll()本质上都是同步I/O，因为他们都需要在读写事件就绪后自己负责进行读写，也就是说这个读写过程是阻塞的
而异步I/O则无需自己负责进行读写，异步I/O的实现会负责把数据从内核拷贝到用户空间
## Keyword
```
edge-trigger: epoll_wait仅会在新的事件首次被加入epoll 对象时返回
    
level-trigger: epoll_wait在事件状态未变更前将不断被触发

system call
    epoll_create: return a file descriptor refering the new epoll instance
        int epoll_create(int size); 

    epoll_ctl: bind the operation "op" be performed for the target "epfd"
        int epoll_ctl(int epfd, int op, int fd, struct epoll_event *event);
        
    epoll_wait: wait for an I/O event on an epoll file descriptor
        int epoll_wait(int epfd, struct epoll_event *events, int maxevents, int timeout);
    
shared memory
```
