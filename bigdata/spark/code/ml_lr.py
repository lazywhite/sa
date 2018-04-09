from pyspark.sql import SparkSession
from pyspark.ml.regression import LinearRegression, RandomForestRegressor
from pyspark.ml.feature import VectorAssembler
from pyspark.sql.functions import col
from pyspark.ml.evaluation import RegressionEvaluator

spark = SparkSession.builder.getOrCreate()

data = spark.read.format("csv").option("header", True).option("inferSchema", True).load("./line.csv")
df = data.select(col("y").alias("label"), "x")


assembler = VectorAssembler(inputCols=["x"], outputCol="features")

df2 = assembler.transform(df)


train, test = df2.randomSplit([0.8, 0.2])


lr = LinearRegression(maxIter=1000, regParam=0.3, elasticNetParam=0.8)
#lr = RandomForestRegressor(labelCol="label", featuresCol="features")

lr_model = lr.fit(train)
prediction = lr_model.transform(test)

evaluator = RegressionEvaluator(labelCol="label", predictionCol="prediction")
accuracy = evaluator.evaluate(prediction)
print(accuracy)

