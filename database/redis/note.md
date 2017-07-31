pipeline
    减少网络延迟花费的时间， 同时提高服务器处理能力

pub/sub
    如果message同时符合pattern和channel， 则client会接受两次message

    1. subscribe <channel> [channel ...]
    >subscribe chann1 chann2
        1) "message"
        2) "chann1"
        3) "hehe"
        1) "message"
        2) "chann2"
        3) "hehe"

    2. publish <channel> <msg>
    >publish chann1 hehe
    >publish chann2 hehe

    3. unsubscribe: 取消对所有channel的订阅
    4. psubscribe <pattern>:  按照pattern进行订阅

DLM: distribute lock manager(解决秒杀等问题)
    1. setnx  lock_name  "value", 如果已存在则什么都不做，表示其他client已经获得了锁, 采用忙轮询继续竞争锁
    2. pexpire lock_name <timeout> 避免获得锁的client不释放锁
    3. del lock_name  如果处理完毕， 正常释放锁

redis keyspace notification
    > del mykey # 将会产生下列操作
    PUBLISH __keyspace@0__:mykey del
    PUBLISH __keyevent@0__:del mykey

    The Key-space channel receives as message the name of the event.
    The Key-event channel receives as message the name of the key.

    $ redis-cli config set notify-keyspace-events KEA
    $ redis-cli --csv psubscribe '__key*__:*'


redis-cli -c (cluster mode, follow ASK, MOVED redirection)
