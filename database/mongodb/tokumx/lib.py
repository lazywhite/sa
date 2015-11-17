from pymongo import MongoClient

REPLSET = 'kok'
conn = MongoClient('mongodb://mongo1:27017,mongo2:27107,mongo3:27017/?replicaSet=%s' % REPLSET,
    readPreference='secondaryPreferred')

