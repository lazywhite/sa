#sqlite3 database.db
sqlite> create table admin(username text,age integer);
sqlite> insert into admin values('kuang',25);
sqlite> select * from admin;
sqlite> update admin set username='kk',age=24 where username='kuang' and age=25;
sqlite> delete from admin where username='kk';


注：每条sql语句后必须以";"号结尾！


2.Sqlite系统命令


.bail ON|OFF           Stop after hitting an error.  Default OFF
.databases             List names and files of attached databases(查看目前挂的数据库)
.dump ?TABLE? ...      Dump the database in an SQL text format(以SQL格式输出表结构)
.echo ON|OFF           Turn command echo on or off
.exit                  Exit this program(退出程序)
.explain ON|OFF        Turn output mode suitable for EXPLAIN on or off.
.header(s) ON|OFF      Turn display of headers on or off
.help                  Show this message(显示帮助信息)
.import FILE TABLE     Import data from FILE into TABLE(把文件中的数据导入到表中,各字段用separator的值为分隔符)
.indices TABLE         Show names of all indices on TABLE
.load FILE ?ENTRY?     Load an extension library
.mode MODE ?TABLE?     Set output mode where MODE is one of:(输出格式)
                         csv      Comma-separated values(各字段以逗号为分隔符输出)
                         column   Left-aligned columns.  (See .width)(以.width设置的宽度显示各字段)
                         html     HTML <table> code(html表格格式输出)
                         insert   SQL insert statements for TABLE(以insert SQL语句形式输出)
                         line     One value per line(field = value的形式逐行输出)
                         list     Values delimited by .separator string(各字段以separator的值为分隔符输出)
                         tabs     Tab-separated values
                         tcl      TCL list elements
.nullvalue STRING      Print STRING in place of NULL values
.output FILENAME       Send output to FILENAME(设置把查询输出到文件,后面的输出结果都保存到文件中)
.output stdout         Send output to the screen(设置把查询结果输出到屏幕,默认)
.prompt MAIN CONTINUE  Replace the standard prompts(修改提示符)
.quit                  Exit this program(退出)
.read FILENAME         Execute SQL in FILENAME(执行文件中的SQL语句)
.schema ?TABLE?        Show the Create statements(以SQL格式输出表结构)
.separator STRING      Change separator used by output mode and .import(修改分隔符)
.show                  Show the current values for various settings(显示配置信息)
.tables ?PATTERN?      List names of tables matching a LIKE pattern(看看有创建了多少表)
.timeout MS            Try opening locked tables for MS milliseconds(超时时间,单位:毫秒)
.width NUM NUM ...     Set column widths for "column" mode(设置列宽)
