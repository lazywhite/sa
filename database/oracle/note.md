oracle表名是区分大小写的

##  keyword
logical structure
    tablespaces
    schema objects
    extents and segments

physical structure
    datafile
    redo log
    control file

schema
数据库实例
redo log

服务名和SID

一般一个oracle database(磁盘文件)对应一个oracle instance(内存进程)
需要分别启动不同的oracle instance
一台服务器可以同时启动多个oracle instance
一个database可以有多个表空间, 每个表空间可以有多个物理的数据库文件

oracle database
    control file
        database name
        location of all datafiles and redo log files
    parameter file
        database name
        memory setting
        location of control file

数据类型
    数字
        number(7, 2) 总共7位, 2位小数
        long
    字符串
        char 长度固定, 不够自动用空格补齐, 默认为1 
        nchar 长度固定
        nvarchar(10) 可存10个汉字
        varchar2(10) 变长, 有编码限制, 最多3个汉字
        varchar 不建议使用
    日期
        date
        timestamp
    二进制
        blob
        clob

常用函数
==================
select now()
   select sysdate from dual;

to_date() 将字符串转化为日期
    select to_date('2012-12-12', 'yyyy-MM-dd') from dual
    
to_char() 将日期转换为字符串
    select to_char(sysdate, 'yyyy-MM-dd') from dual

case when
initcap(): 每个单词首字母均大写
    select initcap('hello world') from dual --> 'Hello World'

instr("str1", "str2"[, start, match])
    start, match 默认都为1, 从str1的第一位开始查找, 返回第1个match的位置
    select instr('oraclrae', 'ra', 1, 2) from dual --> 6
upper()
lower()
round()
    select round(3.1415926, 3) from dual
trunc(3.1415, -1)

nvl()
    select nvl(null, 100) from dual; --> 100
    select nvl('xxx', 100) from dual; --> 'xxx'

count() 
avg() 
min() 
max()

help()
伪列
    rowid 表记录的物理地址(数据库-->表空间-->段-->区-->block) 
        是否可相等
        不能被修改
    rownum


异常
    预定义异常 有名称, DUM_VAL_ON_INDEX
    非预定义异常  定义了异常错误号, 没有名称
    用户自定义异常 需要自己定义, 手动raise

游标
    隐式
    显式
只能使用在存储过程中, 一次提取一行数据

存储过程的参数模式 in, out, in out 调用时out的无需传值

定义存储过程时, 名字不要加双引号
jdbc call oracle procedure   
    Connection conn = ConnUtil.getConnection();
    String sql = "{call add_dept(?, ?, ?)}"
    CallableStatement cs = conn.prepareCall(sql);
    cs.setInt(1, 17);
    cs.execute();

对于带输出参数的procedure, sql需要设置占位符, 传参时仅传递参数类型
    cs.registerOutParameter(2, Types.INTEGER);
    cs.registerOutParameter(3, OracleTypes.CURSOR);
    cs.execute();
    cs.getInt(2); //获取输出参数值
    ResultSset rs = (ResultSet) cs.getObject(3); // 针对游标类型


切换数据库
    export ORACLE_SID='TEST'
    sqlplus  


自增字段
    creat table Persons(P_Id number(20), FirstName varchar(20), LastName varchar(20));
    create sequence seq_person
    minvalue 1
    start with 1
    increment by 1
    cache 100

    INSERT INTO Persons (P_Id,FirstName,LastName)
    VALUES (seq_person.nextval,'Lars','Monsen')

不支持单insert插入values list

oracle里面只能用""修饰字段名, 用''修饰字符串
