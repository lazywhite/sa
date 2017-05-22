mysql_multi --example --> generate example configuration file 
    [mysqld_multi]
    mysqld     = /usr/local/Cellar/mysql/5.7.11/bin/mysqld_safe
    mysqladmin = /usr/local/Cellar/mysql/5.7.11/bin/mysqladmin
    user       = root
    password   = ''

    [mysqld1]
    socket     = /tmp/mysql.sock
    port       = 3306
    pid-file   = /usr/local/var/mysql/hostname.pid
    datadir    = /usr/local/var/mysql
    language   = /usr/local/Cellar/mysql/5.7.11/share/mysql/mysql/english

    [mysqld2]
    socket     = /tmp/mysql.sock2
    port       = 3307
    pid-file   = /usr/local/var/mysql2/hostname.pid2
    datadir    = /usr/local/var/mysql2
    language   = /usr/local/Cellar/mysql/5.7.11/share/mysql/mysql/english


mysqld --initialize-insecure --datadir=/usr/local/var/mysql2 --user=mysql
    root@localhost without password

my_print_defaults --defaults-file=my.cnf <section(mysqld2)>


mysqld_multi --defaults-file=my.cnf start|stop|reload


mysql -S /tmp/mysql.sock2 -P3307 -uroot
