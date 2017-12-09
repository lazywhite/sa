## code
```
pip install pyspark

from pyspark import SparkContext

logfile = 'note.md'

sc = SparkContext("local", "Simple App")
logdata = sc.textFile(logfile).cache()


num_a = logdata.filter(lambda line: 'a' in line).count()
num_b = logdata.filter(lambda line: 'b' in line).count()

print num_a, num_b


运行: pyspark simpleapp.py
```
