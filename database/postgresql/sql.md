# 创建新表 
CREATE TABLE user_tbl(name VARCHAR(20), signup_date DATE);
# 插入数据 
INSERT INTO user_tbl(name, signup_date) VALUES('张三', '2013-12-22');
# 选择记录 
SELECT * FROM user_tbl;
# 更新数据 
UPDATE user_tbl set name = '李四' WHERE name = '张三';
# 删除记录 
DELETE FROM user_tbl WHERE name = '李四' ;
# 添加栏位 
ALTER TABLE user_tbl ADD email VARCHAR(40);
# 更新结构 
ALTER TABLE user_tbl ALTER COLUMN signup_date SET NOT NULL;
# 更名栏位 
ALTER TABLE user_tbl RENAME COLUMN signup_date TO signup;
# 删除栏位 
ALTER TABLE user_tbl DROP COLUMN email;
# 表格更名 
ALTER TABLE user_tbl RENAME TO backup_tbl;
# 删除表格 
DROP TABLE IF EXISTS backup_tbl;




select * from "Asset"; # table name must be quoted

------------ usefull command ---------------
# show variables
show all;
show $variable_name;


## xid
transaction id
select txid_current();

select current_timestamp;
select current_date;
select current_time;
select current_timestamp + interval '1 day';

\x: toggle expanded output
\dn: list current schema

---------- use specific schema ---------
testdb=#set search_path TO sausalito;
testdb=#show search_path;

pg_dump --schema sausalito testdb > sausalito.sql

--------- table space -----------
CREATE TABLESPACE fastspace LOCATION '/mnt/sda1/postgresql/data';

By using tablespaces, an administrator can control the disk layout of a PostgreSQL installation. This is useful in at least two ways. First, if the partition or volume on which the cluster was initialized runs out of space and cannot be extended, a tablespace can be created on a different partition and used until the system can be reconfigured.

Second, tablespaces allow an administrator to use knowledge of the usage pattern of database objects to optimize performance. For example, an index which is very heavily used can be placed on a very fast, highly available disk, such as an expensive solid state device. At the same time a table storing archived data which is rarely used or not performance critical could be stored on a less expensive, slower disk system.


column Type:
    consistency:一致性
    validation:合法性
    compactness:紧凑性
    performance:高性能

point column type
    create table geo_test(id integer, location point, primary key (id));
    insert into geo_test values(1, '(10, 20)')
    

----------- Sequence object (special single-row tables) ----------
create sequence serial start 1010;
select nextval('serial')
select setval('serial', 10)
select nextval('serial')
select lastval()
select  setval('serial', 100)

create table type_test (xml_type xml, uuid_type uuid, json_type json);
insert into type_test values (XMLPARSE (CONTENT 'xyz<foo>bar</foo><bar>foo</bar>'), '550e8400-e29b-41d4-a716-446655440000', row_to_json(row(1, 'foo')));




------------ schema ------------
create schema myschema;
create table myschema.test_table;
    It allows many users to use one database without interfering with each other.
    It organizes database objects into logical groups to make them more manageable.
    Third-party applications can be put into separate schemas so they do not collide with the names of other objects


------- default schema ---------
information_schema
     sql_implementation_info
     sql_languages
     sql_packages
     sql_sizing
     sql_sizing_profiles
     sql_features
     sql_parts

pg_catalog
     pg_statistic
     pg_type
     pg_authid
     pg_attribute
     pg_proc
     pg_user_mapping
     pg_attrdef
     pg_constraint
     pg_index
     pg_operator
     pg_opfamily
     pg_opclass
     pg_am
     pg_amop
     pg_amproc
     pg_language
     pg_database
     pg_aggregate
     pg_rewrite
     pg_trigger
     pg_event_trigger
     pg_description
     pg_cast
     pg_enum
     pg_namespace
     pg_conversion
     pg_depend
     pg_db_role_setting
     pg_tablespace
     pg_pltemplate
     pg_auth_members
     pg_shdepend
     pg_shdescription
     pg_ts_config
     pg_ts_config_map
     pg_ts_dict
     pg_ts_parser
     pg_ts_template
     pg_extension
     pg_foreign_data_wrapper
     pg_foreign_server
     pg_foreign_table
     pg_default_acl
     pg_seclabel
     pg_shseclabel
     pg_collation
     pg_range
     pg_largeobject
     pg_class
     pg_largeobject_metadata
     pg_inherits

public

----------- constraint ----------
not null
unique
primary key
foreign key
check
    CREATE TABLE COMPANY5(
       ID INT PRIMARY KEY     NOT NULL,
       NAME           TEXT    NOT NULL,
       AGE            INT     NOT NULL,
       ADDRESS        CHAR(50),
       SALARY         REAL    CHECK(SALARY > 0)
    );
exclusion
    

------- inherits -------------
create table HH (test_col int) inherits ("Server");

-------- extension -----------
plpgsql PL/pgSQL procedural language

---------- function -------------
CREATE OR REPLACE FUNCTION totalRecords ()
RETURNS integer AS $total$
declare
    total integer;
BEGIN
   SELECT count(*) into total FROM COMPANY;
   RETURN total;
END;
$total$ LANGUAGE plpgsql;



### create column with serial data type will implicitly create a sequence 
###and associate with origin table

---------- storage type --------------
The TOAST code recognizes four different strategies for storing TOAST-able columns:

PLAIN prevents either compression or out-of-line storage; furthermore it disables use of single-byte headers for varlena types. This is the only possible strategy for columns of non-TOAST-able data types.

EXTENDED allows both compression and out-of-line storage. This is the default for most TOAST-able data types. Compression will be attempted first, then out-of-line storage if the row is still too big.

EXTERNAL allows out-of-line storage but not compression. Use of EXTERNAL will make substring operations on wide text and bytea columns faster (at the penalty of increased storage space) because these operations are optimized to fetch only the required parts of the out-of-line value when it is not compressed.


--------- oid support -----------
create table test (id int) with oids=true;
select oid, id from table;

create database TestDB with encoding 'utf-8'




---------- namespace -----------
 A namespace is the structure underlying SQL schemas: each namespace can have a separate collection of relations, types, etc. without name conflicts.

    pg_global



---------- schema -----------

