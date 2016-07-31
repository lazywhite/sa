## database methods
use <dbname> # create new database
db.dropDatabase() # drop database
db
db.getName()
db.version()
db.copyDatabase()


## collection methods
show collections|tables # list collections
db.getCollectionNames()
db.getCollection("col").find({})
db.copyCollection()

## cursor methods
count
explain
forEach
hasNext
hint
itcount
limit
map
maxScan
max
min
next
pretty
size
skip
    skip a number of documents
sort
snapshot
toArray

showRecordId
    db.collection.find( { a: 1 }, { $recordId: 1 } ).showRecordId()
returnKey



## status
db.status()
db.getMongo()

## user
show users

## log
show logs
show log <logname>


## Index
>db.col.ensureIndex({KEY:1})
