## environment
centos6.5 with epel-6 repo enabled
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
migrationtools-47-7.el6.noarch
nfs-utils-1.2.3-64.el6.x86_64
autofs-5.0.5-113.el6.x86_64
httpd-2.2.15-47.el6.centos.x86_64

## procedure

cp /usr/share/openldap-servers/slapd.conf.obsolete /etc/openldap/slapd.conf
slappasswd -s 'rootpw' -h {MD5}
cp /usr/share/openldap-servers/DB_CONFIG.example  /var/lib/ldap/DB_CONFIG
 rm -rf /etc/openldap/slapd.d/*
slaptest  -f /etc/openldap/slapd.conf -F /etc/openldap/slapd.d
chown -R ldap:ldap /var/lib/ldap
chown -R ldap:ldap /etc/openldap/
 service slapd restart

cd /usr/share/migrationtools/
vi  migrate_common.ph

./migrate_base.pl > /tmp/base.ldif
./migrate_passwd.pl  /etc/passwd > /tmp/passwd.ldif
./migrate_group.pl  /etc/group > /tmp/group.ldif

ldapadd -x -D "cn=admin,dc=example,dc=com" -W -f /tmp/base.ldif
ldapadd -x -D "cn=admin,dc=example,dc=com" -W -f /tmp/passwd.ldif
ldapadd -x -D "cn=admin,dc=example,dc=com" -W -f /tmp/group.ldif
ldapadd -x -D "cn=admin,dc=example,dc=com" -W -f /tmp/sudo.ldif

service slapd restart


service rpcbind restart
service nfs restart
service autofs restart


## debug tools
ltrace -f -p <pid> -o <output_file>

sudo -V | grep ldap
ldapsearch -x -W -D "cn=admin,dc=local,dc=com" -s base -b "" -H ldap://10.10.30.11
ldapsearch -x -W -D "cn=admin,dc=local,dc=com" -s children -b "ou=People,dc=local,dc=com" -H ldap://10.10.30.11
