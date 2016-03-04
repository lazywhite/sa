data={journal|ordered|writeback}

ext4文件的优化思路：
    磁盘对齐
	nobarrier
	noatime, nodiratime
	改变块设备物理级别预读大小，而后改变调度器相关的参数，使用更大的预计功能；仅适用于大量顺序读写的场景；
	选择合适的块大小；

xfs文件系统：
	默认已经为较好的设定；
	nobarrier和noatime依然可用；

