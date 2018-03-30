# -*- coding: utf-8 -*-
from pyspark.sql import SparkSession
from pyspark.sql.functions import *
'''
nc -lk 192.168.33.125 5555 # 在spark-submit之前运行
'''


HOST = "192.168.33.125"
PORT = 5555
spark = SparkSession.builder.appName("main").getOrCreate()

lines = spark.readStream.format("socket").option("host", HOST).option("port", PORT).load()


'''
regexp_extract
'''
words = lines.select(
        (split(lines.value, " ")[0]).alias("name"),
        (split(lines.value, " ")[1]).alias("money"),
        )

words = words.withColumn("money", words.money.cast("double"))
count = words.groupby("name").sum()


query = count.writeStream.outputMode("complete").format("console").start()
query.awaitTermination()

