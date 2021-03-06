## environment
centos6.5 with epel-6 repo enabled
make sure cluster time is same 
disable iptables and selinux

## packages of master
python-ldap-2.3.10-1.el6.x86_64
openldap-2.4.40-5.el6.x86_64
openldap-servers-2.4.40-5.el6.x86_64
nss-pam-ldapd-0.7.5-20.el6_6.3.x86_64
openldap-clients-2.4.40-5.el6.x86_64
apr-util-ldap-1.3.9-3.el6_0.1.x86_64
php-ldap-5.3.3-46.el6_6.x86_64
pam_ldap-185-11.el6.x86_64
openssh-ldap-5.3p1-112.el6_7.x86_64
phpldapadmin-1.2.3-1.el6.noarch
nfs-utils-1.2.3-64.el6.x86_64
autofs-5.0.5-113.el6.x86_64
oddjob-mkhomedir-0.30-5.el6.x86_64

migrationtools-47-7.el6.noarch ## provide script to produce ldif files
## procedure

```bash
# enable ldaps in /etc/sysconfig/ldap

cp /usr/share/openldap-servers/slapd.conf.obsolete /etc/openldap/slapd.conf
slappasswd -s 'rootpw' -h {MD5}
cp /usr/share/openldap-servers/DB_CONFIG.example  /var/lib/ldap/DB_CONFIG

# if change rootpwd, should do this again
rm -rf /etc/openldap/slapd.d/*
slaptest  -f /etc/openldap/slapd.conf -F /etc/openldap/slapd.d

chown -R ldap:ldap /var/lib/ldap
chown -R ldap:ldap /etc/openldap/
service slapd start # to generate id2entry.bdb and other files


ldapadd -x -D "cn=admin,dc=example,dc=com" -W -f export.ldif

service slapd restart


chkconfig sssd off
chkconfig nscd off
```

## enable tls support
server.key and client.key should be without password protected
openssl rsa -in private.origin -out private.key


## generate CA and ssl-keys
http://www.ibm.com/developerworks/cn/linux/1312_zhangchao_opensslldap/
## debug tools
ltrace -S -f -p <pid> -o <output_file>

sudo -V | grep ldap
ldapsearch -x -W -D "cn=admin,dc=local,dc=com" -s base -b "" -H ldap://10.10.30.11
ldapsearch -x -W -D "cn=admin,dc=local,dc=com" -s children -b "ou=People,dc=local,dc=com" -H ldap://10.10.30.11


## attention
after add new user to ldap server, should wait a minite to get it applied
ssl-key common-name can not be same with server hostname


## debug

slapd -4 -d127 -h ldaps:/// -f /etc/openldap/slapd.conf

openssl s_client -connect ldap.local.com:636 -CAfile /etc/openldap/cacerts/cacert.pem -showcerts -state
