#Installation

yum install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
yum install Percona-Server-server-56.x86_64
yum install Percona-Server-tokudb-56.x86_64
service  mysqld start
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never > /sys/kernel/mm/transparent_hugepage/defrag
ps_tokudb_admin --enable

show plugins;
show variables like "%tokudb%";
set default_storage_engine = TokuDB 
create table mm(id int primary key) engine=tokudb row_format=tokudb_lzma;
row_format:
    tokudb_zlib (mid-range compression and cpu utilization)
    tokudb_quicklz (light compression and low cpu utilization)
    tokudb_lzma(highest compression and high cpu utilization)
    tokudb_snappy (high speed and reasonable compression)
    tokudb_uncompressed (turn off compression)

## Key features
1. clustering secondary indexes
2. hot index creation
3. compression
4. hotbackup
5. ACID, MVCC



## Hotbackup
1. enable plugin 
ps_tokudb_admin --enable-backup
service mysqld restart 
ps_tokudb_admin --enable-backup
2. set tokudb_backup_dir='/backup/back_2015_01_01/'; #can not  be /root/dir
3. rsync -avrP /data/backup/ /var/lib/mysql/
4. show processlist to view backup states

### debug
SELECT @@tokudb_backup_last_error;
SELECT @@tokudb_backup_last_error_string;
it will backup all tables no matter what storage engine they are using
SET tokudb_backup_throttle=1000000;(bytes) prevent crowding out other jobs 


