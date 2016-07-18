## Introduction
Lightweight Directory Access Protocol, 支持tcp/ip

## Concept
LDIF（LDAP Data Interchange Format，数据交换格式）是LDAP数据库信息的一种文本格式,,用于数据的导入导出，每行都是“属性: 值”对，见 openldap ldif格式示例


## phpldapadmin
yum -y install phpldapadmin
/etc/phpldapadmin/config.php
$servers->setValue('login','attr','dn'); # use dn as login name


## Issue
allow user to change their own password
