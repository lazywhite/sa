## sqlplus
```
进入cli再连接
    sqlplus> connect <username>/<password>@<host>[:<port>]/[database]

直接连接
    # sqlplus connect <username>/<password>@<host>[:<port>]/[database]

```

## Schema
```
定义: 数据库对象的集合, 包含table, view, procedure, sequence等
创建一个用户, 会自动创建一个同名的schema, 在有授权的情况下, 一个用户可以操作不同schema下面的对象
```

## 用户
```
CREATE USER auto_exchange IDENTIFIED BY pass1234 #用户和密码不能引号, 密码不能以数字开头
GRANT RESOURCE TO auto_exchange;
GRANT CONNECT TO auto_exchange;
GRANT CREATE VIEW TO auto_exchange;
GRANT CREATE SESSION TO auto_exchange;
GRANT UNLIMITED TABLESPACE TO auto_exchange;
```

## Sequence
```
SQL> create sequence mysec increment by 1 start with 1;
SQL> create sequence mysec maxvalue 100 increment by -1 start with 100;
SQL> select mysec.nextval from dual;

SQL> drop sequence mysec
show all sequence

```
## dual
```
虚拟表 只有一行一列, 用来配合select凑成语法规则
select user from dual
select sysdate from dual
```

## mysql oracle 命令对照
```
show current database name
    SELECT NAME FROM v$database;
show tables
    select owner, table_name from dba_tables;  
    select owner, table_name from all_tables;
    SELECT table_name FROM user_tables;

desc table
    SELECT COLUMN_NAME , DATA_TYPE FROM all_tab_columns
        WHERE table_name = 'HELP'
        order by table_name
show create table 
    select DBMS_METADATA.GET_DDL('TABLE','TABLE NAME'[,'SCHEMA']) from DUAL

insert into dept(name, loc) values('xx', 'bbbb') -- 字符串必须用单引号

```


## 存储过程
```
声明存储过程时如果名字有双引号, 调用的时候也要加双引号
/* 声明存储过程 */
create or replace procedure p_3a (v_empid number) as -- 没有参数, 不能写()

# 变量声明与赋值
v_a number := 123;
v_s varchar2(20) := '中文';
v_d date ;

v_ename emp.ename%type; -- 属性类型声明
v_job emp.jon%type;
v_pi constant number(8, 7) := 3.1415926; -- 常量声明

begin
	v_d := to_date('2012-12-12', 'yyyy-MM-dd');
	select ename into v_ename from emp where empno = empid;
	select job into v_job from emp where empno = empid;

	dbms_output.put_line('姓名是:' || v_ename|| ' 职位是:' || v_job);

end;
------------------

调用
------------------
/* plsql 匿名存储过程*/
DECLARE
    begin
        p_3a(2001);
    end;

------------------


------------------
create or replace procedure p_3b (v_empid number) as 

v_emp emp%rowtype;  -- 获取整行数据到一个对象里面

begin 
	select * into v_emp from emp where empno = v_empid;
	dbms_output.put_line("名字是:" || v_emp.ename || ", 职位是:" || v_emp.job);

end p_3b;

------------------
```


## 游标
```
------------------
CREATE OR REPLACE
PROCEDURE "p_cursor" (v_dno in number, v_c out number) AS
	cursor mycur is
		select ename, job from emp where dno = v_dno;  -- 声明游标

	v_ename emp.ename%type;
	v_job emp.job%type;

BEGIN
	select count(*) into v_c from emp where dno = v_dno;

	if not mycur%isopen THEN
		open mycur;   -- 打开游标
	end if;

	loop

		fetch mycur into v_ename, v_job;  -- 提取数据
		exit when mycur%notfound;  -- 退出语句必须紧跟fetch语句

		dbms_output.put_line('第' || mycur%rowcount || '行' || ' v_ename:' || v_ename || ', v_job:' || v_job);


	end loop;

	close mycur;  -- 关闭游标


END;
------------------

游标内更新数据
------------------
CREATE OR REPLACE
PROCEDURE "p_cur2" AS



	cursor mycur is
		select ename, salary, job from emp for update;
		-- select ename, salary, job from emp, dept for update *emp*; 指定更新表


	v_emp mycur%rowtype; -- 基于游标的变量

BEGIN

	open mycur;

	loop
		fetch mycur into v_emp;
		exit when mycur%notfound;

		if v_emp.salary < 3000 then
			if v_emp.salary <= 2500 THEN
				update emp set salary = salary + 500 where current of mycur;
			ELSE
				update emp set salary = 3000 where current of mycur;
			end if;
		else
			dbms_output.put_line(v_emp.ename || '不符合涨薪条件');
		end if;

	end loop;

	close mycur;
END;
------------------


迭代游标
------------------
CREATE OR REPLACE
PROCEDURE "p_cur3"(v_dno number) AS
	cursor mycur is
		select ename, salary, age from emp where dno = v_dno;
BEGIN
	for emp_rec in mycur loop
		dbms_output.put_line('line:' || mycur%rowcount || ' '|| emp_rec.ename|| ' '|| emp_rec.salary|| ' '||emp_rec.age);
	end loop;
END;

------------------

返回游标
------------------
CREATE OR REPLACE
PROCEDURE p_cur4 (mycur out SYS_REFCURSOR) AS
BEGIN
  open mycur for
	select empno, salary from emp;
END;
------------------
```

## 流程控制语句
```
------------------
CREATE OR REPLACE
PROCEDURE "p_flow" AS
v_c number := 1;
BEGIN

	loop


		if v_c > 10 then
			goto endloop;
		end if;

		if v_c > 5 then
			v_c := v_c + 2;
		else
			v_c := v_c + 1;

		end if;
		dbms_output.put_line('v_c=' || v_c);

	end loop;

	<<endloop>>
	dbms_output.put_line('end of procedure');  -- label 之后一定要有语句, 不然会编译错误

END;

------------------

```


## Function 
------------------
CREATE OR REPLACE
FUNCTION get_avg_salary(v_dno number) RETURN NUMBER AS
	v_avg_salary number; 
BEGIN
  select avg(salary) into v_avg_salary from emp where dno = v_dno;
	if v_avg_salary > 3000 then
		return v_avg_salary;
	else
		return null;
	end if;
END;

declare 
	v_avg number;
BEGIN	
	v_avg := get_avg_salary(10);
	dbms_output.put_line(v_avg);
end;
------------------

## View
1. 简单视图: 只涉及单表
2. 复杂视图: 涉及多表

视图依赖于底层表, 如果底层表丢失, 则view非法

数据隔离
权限控制

DML(insert, update, delete) 更改视图的限制
	不能执行有歧义的操作
	1. 操作只能涉及一个基表
	2. 不能更改含有group by, distinct等语句的视图
    3. 不能更改有函数, 复杂表达式的字段
    4. 单个字段简单的别名, 不影响操作
------------------
create or replace view emp_view as
	select ename, salary, dno from emp

drop view emp_view;
------------------



package
================
对存储过程, 函数, 变量, 游标的封装

package 声明
--------------
create or replace package my_pack

as


	procedure count_emp(v_dno in number, v_count out number);
	function get_avg(v_dno in number) return number;

end;
--------------

package body
--------------
create or replace package body my_pack

as
	
	procedure count_emp(v_dno in number, v_count out number) as
	begin
		select count(*) into v_count from emp where dno = v_dno;
	end count_emp;

	function get_avg(v_dno in number) return number as
		avg_salary number;
	begin
		select avg(salary) into avg_salary from emp  where dno = v_dno;
		return avg_salary;
	end get_avg;
end;

--------------
package 调用
--------------
declare 
	xx number;
begin
	select my_pack.get_avg(20) into xx from dual;  
-- mypack.get_avg(20)  错误, 提示找不到, 有返回值的要严格赋值
	dbms_output.put_line(xx);
end;
--------------

## 数据字典
user_tables
user_objects
user_constraints
user_views
user_tablespaces

无法从数据字典中直接删除对应的object, 需要手动drop 


## 触发器
时间点
	BEFORE
	AFTER
	INSTEAD OF

只能对DML, DDL规定trigger
--------------
create or replace trigger back_emp 
	before delete on EMP

	for each row
	when (old.dno <> 10)

	begin
		-- 必须用:old, 不能不加:
		insert into emp_del(empno, ename) values(:old.empno, :old.ename); 
	end;
--------------


## 表空间 tablespace
--包含数据库中所有表空间的描述信息
SELECT * FROM DBA_TABLESPACES

--包含当前用户的表空间的描叙信息
SELECT * FROM USER_TABLESPACES

--包含从控制文件中获取的表空间名称和编号信息
SELECT * FROM V$TABLESPACE;

查看数据文件

--包含数据文件以及所属的表空间的描述信息
SELECT * FROM DBA_DATA_FILES


--包含临时数据文件以及所属的表空间的描述信息
SELECT * FROM DBA_TEMP_FILES
 

--包含从控制文件中获取的数据文件的基本信息，包括它所属的表空间名称、编号等
SELECT * FROM V$DATAFILE

--包含所有临时数据文件的基本信息
SELECT * FROM V$TEMPFILE

```
CREATE TABLESPACE TBS_TR_DATA
DATAFILE '/oradata/rTBS_TR_DATA_001.dbf'
SIZE 64G 
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO ONLINE;
 
 
ALTER TABLESPACE TBS_TR_DATA
ADD DATAFILE '/oradata/rTBS_TR_DATA_002.dbf'
SIZE 64G
AUTOEXTEND OFF;
```


## delimiter
```
To change the command delimiter from the default value of ; use

SQL> set cmdsep /
SQL> show cmdsep
cmdsep "/" (hex 2f)

To restore the default value after you've created your trigger:

SQL> set cmds off
SQL> show cmds
cmdsep OFF)
```

## dblink


# 分页
```
select a1.* from (select student.*,rownum rn from student) a1 where rn between 3 and 5;

```

## sqlplus 执行sql文件
```
sqlplus> @/path/to/script.sql
sqlplus> commit; # 必须
```



## Synonym
```
create [public] synonym F_DEPT_H for F_DEPT_H@LINK_test
select * from dba_synonyms where synonym_name like 'F_DETP%'
DROP [public] synonym F_DEPT_H;
```
