from lib import conn
db = conn.get_database('local')

for i in db['oplog.rs'].find():
    print i
