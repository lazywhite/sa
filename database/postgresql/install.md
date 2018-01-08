[tutorials](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-centos-7)  


```
# yum -y install postgresql-server postgresql-contrib postgresql
# postgresql-setup initdb --pgdata=/var/lib/pgsql/data --encoding=UTF-8
# vim /var/lib/pgsql/data/pg_hba.conf
    host    all             all             127.0.0.1/32            md5
    host    all             all             ::1/128                 md5
# vim /var/lib/pgsql/data/postgresql.conf
    listen_addresses = '*'
 
# systemctl start postgresql
# su - postgres
# createdb metastore
# createuser --interactive (hive)
# psql 
# alter database metastore owner to hive;
# \password hive
# psql -h localhost -U hive -W metastore
```
