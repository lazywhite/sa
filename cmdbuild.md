# Installation
## Prepare environment
1. postgresql
2. jdk-1.6
3. tomcat6

## Software
1. cmdbuild
2. shark

## configuration

### PostgreSQL
/var/lib/pgsql/9.4/data/pg_hba.conf  #enable remote access
host    all             all             0.0.0.0/24              password

/var/lib/pgsql/9.4/data/postgresql.conf 
listen_addresses = '*' 

------ change password ----------
#su - postgres
>psql
\password postgres
create user dbuser with password 'password'
create database exampledb owner dbuser encoding 'utf-8';
grant all privileges on database exampledb to dbuser;

------ connect to psql -----------
psql -h<host> -U<user> -W -d<databa>

------ related command ----------
alter user dbuser password 'password';
\l: list databases
\c <db>: connect to other database
\du: display user
\conninfo: display connection information

### configure cmdbuild
unzip cmdbuild.zip 
cp ~/cmdbuild-2.3.4/cmdbuild-2.3.4.war  /user/share/tomcat6/webapps/cmdbuild.war
cp ~/cmdbuild-2.3.4/extras/tomcat-libs/6.0/postgresql-9.1-901.jdbc4.jar 
    /usr/share/tomcat6/lib/

service tomcat6 start

http://<ip>:8080/cmdbuild   # follow the installation procedure



### configure shark
unzip shark-cmdbuild-2.3.4.zip
cp /root/shark-cmdbuild-2.3.4/cmdbuild-shark-server-2.3.4.war  /usr/share/tomcat6/webapps/shark.war

cd /usr/share/tomcat6/webapps/cmdbuild/WEB-INF/sql/shark_schema/
psql -Upostgres -W -h192.168.1.190 -d cmdb_demo < 01_shark_user.sql
    psql#>alter user shark password 'shark'

psql -Upostgres -W -h192.168.1.190 -d cmdb_demo < 02_shark_emptydb.sql

### configure cmdb api user
cmdb_admin_module --> User and Group --> change password of 'workflow' 

/usr/share/tomcat6/webapps/shark/conf/Shark.conf
    # CMDBuild connection settings
    org.cmdbuild.ws.url=http://192.168.1.190:8080/cmdbuild/
    org.cmdbuild.ws.username=workflow
    org.cmdbuild.ws.password=changeme

/usr/share/tomcat6/webapps/cmdbuild/WEB-INF/conf/auth.conf
    serviceusers.prigileged=admin, workflow

/usr/share/tomcat6/webapps/cmdbuild/WEB-INF/conf/database.conf


xpdl template must have same class name with process class

### configure share database user
/etc/tomcat6/Catalina/localhost/shark.xml
     url="jdbc:postgresql://192.168.1.190/cmdb_demo"
     username="shark"
     password="shark"


/usr/share/tomcat6/webapps/shark/META-INF/context.xml
    url="jdbc:postgresql://192.168.1.190/cmdb_demo"

/etc/tomcat/tomcat6.conf
     TOMCAT_USER="root" 

cmdbuild-->Administration module --> setup --> workflow engine -->Processes
--> upload  (/root/cmdbuild-2.3.4/extras/workflow/RFC/RequestForChange.xpdl)

service tomcat6 restart
