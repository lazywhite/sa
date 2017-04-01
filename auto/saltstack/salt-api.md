## Installation
```
1. yum -y install salt-api
2. useradd -M salt
3. echo 'salt'|passwd --stdin salt

4. openssl genrsa -out /etc/ssl/private/key.pem 4096
5. openssl req -new -x509 -key /etc/ssl/private/key.pem -out /etc/ssl/private/cert.pem -days 1826


6. /et/salt/master.d/api.conf
external_auth:
	pam:
		salt:
      		- .*

rest_cherrypy:
  port: 8000
  host: 0.0.0.0
  disable_ssl: False  # whether to use ssl
  ssl_crt: /etc/ssl/private/cert.pem
  ssl_key: /etc/ssl/private/key.pem

7. /etc/init.d/salt-master restart
8. /etc/init.d/salt-api restart
```
## auth backend type
```
pam
LDAP
AD
```

## Example
```
Request 01
    curl -ki http://127.0.0.1:8082/login -H "Accept: application/json" \
     -d username='salt' \
     -d password='salt' \
     -d eauth='pam'
Response 01
    {"return": [{"perms": [".*"], "start": 1491028832.400423, "token": "c26a6e61f83f9e44320371157c6ba551ddf3dba4", "expire": 1491072032.400424, "user": "salt", "eauth": "pam"}]}%

Request 02
    curl -i http://localhost:8082/ -H "Accept: application/json"  -H "X-Auth-Token: c26a6e61f83f9e44320371157c6ba551ddf3dba4" -d client='local' -d tgt='2ec8cdb49718' -d fun="cmd.run" -d arg="uname -a"

Response 02
    {"return": [{"2ec8cdb49718": "Linux 2ec8cdb49718 4.9.12-moby #1 SMP Tue Feb 28 12:11:36 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux"}]}%
```
