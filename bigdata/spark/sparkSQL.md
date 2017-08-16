## Introdcution
A programming module for structured data processing. it provides a programming  
abstraction called DataFrame and can act as distributed SQL query engine.  


## Architecture  

```
1. Language API
2. Schema RDD
    SparkSql -->Schema RDD --> DataFrame
3. Data Sources
    text file, parquet file, json document, hive tables, cassandra database
```


## DataFrame
a dataframe is a distributed collection of data, which is organized into named  
columns, Conceptually, it is equivalent to relational tables.


### SQLContext
SQLContext is a class and is used for initializing the functionalities of  
sparkSQL. by default  SparkContext object is initialized with the name "sc" 
when the spark-shell starts    


```
val sqlContext = new org.apache.spark.sql.SQLContext(sc)
val dfs = sqlContext.read.json("ep.json")
dfs.show()
dfs.printSchema()
dfs.select("name").show()
dfs.filter(dfs("age") > 23).show()
dfs.groupBy("age").count().show()

dfs.createOrReplaceTempView("people");
Dataset<Row> sqlDF = spark.sql("SELECT * FROM people");
sqlDF.show();
```
