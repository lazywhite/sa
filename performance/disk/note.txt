io_scheduler
	cfq: 完全公平队列调度
	deadline: 最终期限调度
	anticipatory
	noop

持久化
    /etc/rc.d/rc.local
        echo "<io_scheduler>" > /sys/block/<dev>/queue/scheduler

Queue length
/sys/block/<dev>/queue/nr_requests

Max read-ahead
/sys/block/<dev>/queue/read_ahead_kb



IO压力测试工具：
	aio-stress
	iozone
	fio
	磁盘活动状况分析：blktrace, blkparse
	gnuplot

