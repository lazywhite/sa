# -*- coding: utf-8 -*-
from pyspark.ml import Pipeline
from pyspark.ml.feature import VectorAssembler
from pyspark.ml.classification import LogisticRegression

from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("main").getOrCreate()


train_data = "/Users/white/iris.csv"
test_data = "/Users/white/iris_test.csv"

iris = spark.read.option("inferSchema", True).csv(train_data)
iris_test = spark.read.option("inferSchema", True).csv(test_data)

lr = LogisticRegression(maxIter=10,regParam=0.001,
            featuresCol="features",
            labelCol="_c4"
            )

assembler = VectorAssembler(inputCols=["_c0", "_c1", "_c2", "_c3"],
                            outputCol="features")


pipeline = Pipeline(stages=[assembler, lr])

model = pipeline.fit(iris)
prediction = model.transform(iris_test)

prediction.select("prediction").show(1000, False)

