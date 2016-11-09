from __future__ import print_function
import xmlrpclib
import base64
import socket 
import sys
import json


vals = {}
vals['app_id'] = sys.argv[1]
vals['app_version_name'] = sys.argv[2]
vals['app_version'] = sys.argv[3]
vals['app_dwn_path'] = sys.argv[4]
vals['app_plist_path'] = sys.argv[5]
vals['size'] = sys.argv[6]


sock_common = xmlrpclib.ServerProxy('http://dist.test.com:8069/xmlrpc/common', verbose=1, allow_none=1)
oe_uid = sock_common.login('app_dist', "iposbuilder", "5FB2C70A-2631-4584-AC31-")


if oe_uid != False:
    print("login ok")
    sock = xmlrpclib.ServerProxy('http://dist.test.com:8069/xmlrpc/object', verbose=1, allow_none=1)
    
    result = sock.execute('app_dist', oe_uid, "5FB2C70A-2631-4584-AC31-", 'nt.app.distribute.version', 'register', vals)
    with open('../version_history.txt', 'a') as f:
        print(json.dumps(vals), file=f)
