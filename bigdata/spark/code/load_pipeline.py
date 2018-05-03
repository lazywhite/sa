# -*- coding: utf-8 -*-
#
# Copyright © 2018 white <white@Whites-Mac-Air.local>
#
# Distributed under terms of the MIT license.
from pyspark.ml import PipelineModel
from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("main").getOrCreate()
model = PipelineModel.load("/Users/white/local/ml_model")


test = spark.createDataFrame([
    (4, "spark i j k"),
    (5, "l m n"),
    (6, "spark hadoop spark"),
    (7, "apache hadoop")
], ["id", "text"])

prediction = model.transform(test)

prediction.show(100, False)
