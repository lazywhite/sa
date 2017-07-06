## 新增记录
```
db.col.insert()  
db.col.insertOne()  
db.col.insertMany(
    [<doc1>, <doc2>...],
    {ordered: <boolean>}
)  

db.users.insert(   	  # collection
    {
        name: "sue",  # field: value
        age: 26,
        status: "A"
    }
)
```

## 查询

### 1. 操作符
```
$gt 
	{field: {$gt: value} }
$gte 
$lt 
$lte 
$ne

$exists
    { field: { $exists: <boolean> } }
    查询包含或者不包含对应字段的document

$all
    { <field>: { $all: [ <value1> , <value2> ... ] } }
    当对应的字段为数组时, 要求所有值都匹配

$mod
    { field: { $mod: [ divisor, remainder ] } }
    查询 字段值  value/divisor = remainer 的所有document

$in
    { field: { $in: [<value1>, <value2>, ... <valueN> ] } }
    当对应的字段为数组时, 要求包含查询的值   

$nin
    { field: { $nin: [ <value1>, <value2> ... <valueN> ]} }
    查询不存在此字段或者字段的数组中不包含查询值的document

$size
    { field: { $size: <count> } } 
    查询对应字段是数组, 并且数组的长度是count的document

```

### 2. 游标方法
```
db.col.find()默认返回游标, 需要迭代游标来获取document, 默认被迭代20次输出前20个document

遍历一个cursor
    var cursor = db.col.find()
    cursor.forEach(printjson)
        or 
    while(cursor.hasNext()){
        printjson(cursor.next())
    }

limit(num)
skip(num): num越大, 操作越慢, 官方推荐range-based pagination
sort({field1: 1, field2: -1})
count()
map(function(u){return u.name})
size(), 当对cursor应用skip(), limit()之后, 用此方法获取总数
```
### 3. 限制输出的字段 projection
```
db.inventory.find({type: "food"}) 返回所有字段
db.inventory.find({type: "food"}, {item: 1, qty: 1, _id: 0}) //返回指定字段, _id默认会返回, 除非置为0

db.inventory.find({type: "food"}, {item: 0}) //返回除item的所有字段

```
## Update
  
```
db.col.update()
db.col.updateOne()
db.col.updateMany()
db.col.replaceOne()

update(
    <match>,
    <update>,
    <option>
)

db.users.update(              
	{ age: { $gt: 18} },		# 匹配规则
	{ $set: { status: "A"} , $inc: { stock: 5 }},
	{ multi: true ,            # 更改所有符合条件的doc, 没有则只修改一行, 
      upsert: true             # 如果匹配不到document, 则insert一条document
    }				
)
```

## Delete
```
db.col.remove(
    <query>,
    <justOne>
)
db.users.remove(
    { status: "D" },  # remove cretiria
    { justOne: false}  # 删除所有匹配的document
)
db.col.remove() 将删除所有document

db.col.deleteOne()
db.col.deleteMany()

```

### Examples 
```
var p = {"uid":10001, "name": "allien", "age": 32}
db.col.insert(p)
db.col.find({}, {'column': 1}) # select column from col;
db.col.find({age:{$gte:18}}) # select * from table where age > 18;
db.col.find({uid: 10001}, {name:1, _id:0 }) # select name from table where uid=10001

db.col.find({uid: {$exists: true}})
db.col.find().sort({uid:-1})  select * from col order by uid desc;
db.col.find({age: {$ne: 19}}) select * from col where age != 19;
db.col.find({age: {$in: [1,2,3,19]}}) select * from col where age in (1, 2, 3, 19);
```
