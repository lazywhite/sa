# -*- coding: utf-8 -*-
from pyspark.ml import Pipeline
from pyspark.ml.feature import VectorAssembler
#from pyspark.ml.classification import DecisionTreeClassifier
from pyspark.ml.classification import RandomForestClassifier
from pyspark.ml.evaluation import MulticlassClassificationEvaluator

from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("main").getOrCreate()


train_data = "./iris.csv"
test_data = "./iris_test.csv"

iris = spark.read.option("inferSchema", True).csv(train_data)
iris_test = spark.read.option("inferSchema", True).csv(test_data)

#dt = DecisionTreeClassifier(featuresCol="features", labelCol="_c4")
dt = RandomForestClassifier(featuresCol="features", labelCol="_c4", numTrees=3)

assembler = VectorAssembler(inputCols=["_c0", "_c1", "_c2", "_c3"],
                            outputCol="features")


pipeline = Pipeline(stages=[assembler, dt])

model = pipeline.fit(iris)
prediction = model.transform(iris_test)

evaluator = MulticlassClassificationEvaluator(labelCol="_c4", predictionCol="prediction", metricName="accuracy")
accuracy = evaluator.evaluate(prediction)
print(accuracy)
