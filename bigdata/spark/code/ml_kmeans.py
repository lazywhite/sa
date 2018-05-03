# -*- coding: utf-8 -*-
'''
无法在2.2.1使用
'''
from pyspark.sql import SparkSession
from pyspark.ml.clustering import KMeans
#from pyspark.ml.evaluation import ClusteringEvaluator
from pyspark.ml.evaluation import ClusteringEvaluator


data_file = "./sample_kmeans_data.txt"
spark = SparkSession.builder.getOrCreate()

#kmeans = KMeans().setK(2).setSeed(1)
kmeans = KMeans(k=2, seed=1)

dataset = spark.read.format("libsvm").load(data_file)

model = kmeans.fit(dataset)
prediction = model.transform(dataset)
prediction.show(truncate=False)

evaluator = ClusteringEvaluator()
accuracy = evaluator.evaluate(prediction)

