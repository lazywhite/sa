
## Usage
spark-shell  
pyspark  

```
scala> val textFile = sc.textFile("hdfs://localhost:9000/user/white/wordcount/words.txt")
scala> textFile.count()

```
