show slave status;
show master status
stop slave
start slave

reset slave
    clears the master info and relay log info, delete all the relay log files and starts a new relay log file, also resets "replication delay" to 0

change master to master_host='192.168.1.124', master_user='back', master_password='back', master_log_file='mysql-bin.000013', master_log_pos=98; 
    恢复一个slave时， show slave status查看复制位置

reset master
    clear all binary logs and create a new binary log

show binary|master logs
    list binary log files on this server
