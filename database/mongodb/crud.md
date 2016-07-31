### Insert

 
```
db.col.insert()  
db.col.insertOne()  
db.col.insertMany()  

db.users.insert(   	  # collection
    {
        name: "sue",  # field: value
        age: 26,
        status: "A"
    }
)
```

### Read

```
$gt 
	{field: {$gt: value} }
$gte 
$lt 
$lte 
$ne

$exists
    { field: { $exists: <boolean> } }
    When <boolean> is true, $exists matches the documents that contain the field, including documents where the field value is null. If <boolean> is false, the query returns only the documents that do not contain the field. 

$all
    { <field>: { $all: [ <value1> , <value2> ... ] } }
    selects the documents where the value of a field is an array that contains all the specified elements.

$mod
    { field: { $mod: [ divisor, remainder ] } }
    select documents where the value of a field divided by a divisor has the specified remainder (i.e. perform a modulo operation to select documents

$in
    { field: { $in: [<value1>, <value2>, ... <valueN> ] } }
    selects the documents where the value of a field equals any value in the specified array.
    
$nin
    { field: { $nin: [ <value1>, <value2> ... <valueN> ]} }
    selects the documents where:
        the field value is not in the specified array or
        the field does not exist.

$size
    { field: { $size: <count> } } 
    matches any array with the number of elements specified by the argument.

```

```
db.users.find(  #collection
    { age: { $gt: 18 } },   # query criteria
    {name: 1, address: 1}   # projection
).limit(5)                  # cursor modifier

```
### Update
  
```
db.col.update()
db.col.updateOne()
db.col.updateMany()
db.col.replaceOne()

db.users.update(              # collection
	{ age: { $gt: 18} },		# update cretiria
	{ $set: { status: "A"} },	# update action 
	{ multi: true }				# update option
)
```

### Delete
```
db.col.remove()
db.col.deleteOne()
db.col.deleteMany()

db.users.remote(
    { status: "D" }  # remove cretiria
)
```

### Examples 
```
var p = {"uid":10001, "name": "allien", "age": 32}
db.col.insert(p)
db.col.find()
db.col.find({age:{$gte:18}}) # select * from table where age > 18;
db.col.find({uid: 10001}, {name:1 }) # select name from table where uid=10001
var ret = db.col.find( { uid: 10001},{name:1 }).toArray(); ret[0].name # store query result into variable

for (var i = 1;i<5;i++){
    db.col.insert(
        {"name":"robot"+i, "age":i}
    )
}

db.col.find().forEach(printjson)
var cursor = db.col.find()
printjson(cursor[3])

var arr = cursor.toArray()
arr[3]


db.col.find({uid: {$exists: true}})
db.col.find().sort({uid:-1})
db.col.find({age: {$ne: 19}})
db.col.find({age: {$not : {$ne: 19}}})
db.col.find({age: {$in: [1,2,3,19]}})
db.col.find().sort({"uid":-1}) # select * from table order by uid desc;
```
