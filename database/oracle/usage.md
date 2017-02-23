#  sqlplus

## 1. show databases
```
SELECT NAME FROM v$database;
```
## 2. show tables
```
select owner, table_name from dba_tables;  
select owner, table_name from all_tables;
SELECT table_name FROM user_tables;
```
## 3. show table columns
```
desc <table>
```
## 4. 显示建表语句
```
select DBMS_METADATA.GET_DDL('TABLE','TABLE NAME'[,'SCHEMA']) from DUAL
```
