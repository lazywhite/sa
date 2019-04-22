# -*- coding: utf-8 -*-
from pyspark import AccumulatorParam
from pyspark.sql import SparkSession

spark = SparkSession.builder.getOrCreate()

class ListParam(AccumulatorParam):
    def zero(self, v):
        return []
    def addInPlace(self, acc1, acc2):
        acc1.extend(acc2)
        return acc1

l1 = spark.sparkContext.accumulator([], ListParam())

def add_it(row, accu):
    accu += [row['x']]

df = spark.createDataFrame([[1, 2], [3, 4]], ("x", "y"))

df.foreach(lambda row: add_it(row, l1))

print(l1.value)
