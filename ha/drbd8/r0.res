resource r0 {
    # DRBD device
    device /dev/drbd0;
    # block device
    disk /dev/drbdpool/lvol0;
    meta-disk internal;
    on node4 {
        # IP-address:port
        address 172.31.191.4:7788;
    }
    on node5 {
        address 172.31.191.5:7788;
    }
}

