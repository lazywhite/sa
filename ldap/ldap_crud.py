import random
import sys
import ldap
import commands
import ldap.modlist as modlist

LDAP_HOST = '10.10.30.11'
USER = 'cn=admin,dc=local,dc=com'
PASSWORD = 'hehe'
STATICPW = 'platpw'
baseDN = "ou=People,dc=local,dc=com"




def gen_slap_pw(passwd):
    status, output = commands.getstatusoutput('slappasswd -s %s -h {MD5}' % passwd)
    return output.strip()

def search_user(username):
    rid = i.search(baseDN, ldap.SCOPE_SUBTREE, "uid=%s" % username, None)

    result_type, result_data = i.result(rid, 0)
    if result_type == ldap.RES_SEARCH_ENTRY:
        return result_data


def update_user_pw(username, oldpass):
    dn = "uid=%s,ou=People,dc=local,dc=com" % username
    old = {'userPassword':oldpass}
    new = {'userPassword':[gen_slap_pw(gen_token()+ STATICPW)]}

    ldif = modlist.modifyModlist(old, new)
    i.modify_s(dn, ldif)


def gen_token():
    s = []
    for i in range(8):
        s.append(chr(random.randint(65,90)))
    token = ''.join(s)
    with open('/tmp/token', 'w+') as file:
        file.write(token)

    return token

    

if __name__ == '__main__':
    uid = sys.argv[1]
    try:
        i = ldap.init(LDAP_HOST)
        i.simple_bind(USER, PASSWORD)
    except Exception as e:
        print e
        sys.exit(10)

    result_data = search_user(uid)
    oldpass = result_data[0][1]['userPassword']
    update_user_pw(uid, oldpass)

    i.unbind_s()
