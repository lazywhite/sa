## Introdcution
A programming module for structured data processing. it provides a programming  
abstraction called DataFrame and can act as distributed SQL query engine.  

## Feature
```
1. Integrated: 
    Seemlessly mix SQL queryies with Spark programs, like query RDD 
2. unified data access
    Load and query data from a varriety of sources. Schema-RDDs provide 
    a single interface for efficiently working with structured data,   
    including Hive Tables, JSON files
3. Hive compatibility
    Run Hive query on existing warehourses
4. Standard Connectivity
    Spark can run in "Server Mode" which has "JDBC, ODBC" connectivity
5. Scalability
    mid-query fault tolerance, letting it scale to large jobs

```

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

### Feature
```
1. ability to process the data in the size of Kilobytes to Petabytes
2. support different data formats
3. state of art optimization and code generation
4. easily integretaed with all BigData tools and frameworks via Spark-Core
5. Provides API for Python, Java, Scala and R programming
```

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

```





