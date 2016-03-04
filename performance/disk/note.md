io_scheduler
	cfq
	deadline
	anticipatory
	noop

持久化
    /etc/rc.d/rc.local
        echo "io_scheduler" > /sys/block/<dev>/queue/scheduler

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

