## 一、 前提条件  

```
Oracle Server: 11.2.0
Oracle Client:  11.2.0
192.168.1.1  安装Oracle Server
192.168.1.2  安装Oracle Client
```
## 二、流程说明
```
客户机安装Oracle Instant Client   相关RPM包
客户机添加环境变量
从Oracle Server拷贝sqlldr, exp, imp 可执行文件及所需的message文件 到客户机
```
## 三、详细过程
 
```
1. 下载下列rpm包到客户机
# oracle-instantclient11.2-basic-11.2.0.4.0-1.x86_64.rpm
# oracle-instantclient11.2-devel-11.2.0.4.0-1.x86_64.rpm
# oracle-instantclient11.2-jdbc-11.2.0.4.0-1.x86_64.rpm
# oracle-instantclient11.2-odbc-11.2.0.4.0-1.x86_64.rpm
# oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.x86_64.rpm
# oracle-instantclient11.2-tools-11.2.0.4.0-1.x86_64.rpm
 
 
2. 安装
# rpm -ivh *.rpm
 
3. 添加环境变量
# echo "export ORACLE_HOME=/usr/lib/oracle/11.2/client64" >> /etc/profile
# source /etc/profile
 
4. 持久化Oracle动态链接库配置
#  cat > /etc/ld.so.conf.d/oracle-client-11.2.0.conf <<EOF
/usr/lib/oracle/11.2/client64/lib/
EOF
 
# ldconfig
 
 
 
# 5. 在Oracle Server上找到下面文件， 在客户机$ORACLE_HOME下创建下列相应的文件夹 将对应文件拷贝过来
/usr/oracle/product/11.2.0/db_1/
    bin
        exp
        imp
        sqlldr
    rdbms
        mesg
            ulus.msb
            expus.msb
            impus.msb
 
# 6. sqlplus  <user>/<password>@<host>/<dbname>  # 测试能否正常连接

```
     
