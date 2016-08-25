## Introduction
Lightweight Directory Access Protocol, 支持tcp/ip

## Concept

Entry
    dn: distinguished name
    attributes
    object classes

DN: distinguished name
RDN: relative distinguished name

DC: Domain Component
OU: Organization Unit
CN: Common Name

Attribute: data for an Entry, each attribute has an attribute type, zero or more
attribute options and a set of values that comprise the actual data

Attribute types: are schema elements that specify how attributes should be treated by LDAP clients and servers, All attribute types must have an object identifier (OID) and zero or more names that can be used to reference attributes of that type.


    
## phpldapadmin
yum -y install phpldapadmin
/etc/phpldapadmin/config.php
$servers->setValue('login','attr','dn'); # use dn as login name



