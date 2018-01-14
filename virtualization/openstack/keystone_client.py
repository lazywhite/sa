# -*- coding: utf-8 -*-
'''
必须能直接访问adminURL
'''
from keystoneauth1.identity import v2
from keystoneauth1 import session
from keystoneclient.v2_0 import client
username='admin'
password='admin'
tenant_name='admin'
auth_url='http://192.168.0.3:5000/v2.0'
auth = v2.Password(username=username, password=password,
                   tenant_name=tenant_name, auth_url=auth_url)
sess = session.Session(auth=auth)
keystone = client.Client(session=sess)

print keystone.tenants.findall()

