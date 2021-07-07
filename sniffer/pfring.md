PF_RING 
    高性能抓包，过滤，分析工具
    包含userspace driver和kernel module两部分
    PF_RING ZC library for distributing packets in zero-copy across threads, applications, Virtual Machines.


userspace
    ZC (new generation DNA, Direct NIC Access) drivers for extreme packet capture/transmission speed as the NIC NPU (Network Process Unit) is pushing/getting packets to/from userland without any kernel intervention. Using the 10Gbit ZC driver you can send/received at wire-speed at any packet sizes.

kernel module
    mod_probe pf_ring

