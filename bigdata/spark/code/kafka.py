# -*- coding: utf-8 -*-
from pyspark.sql import SparkSession

"""
pyspark --packages org.apache.spark:spark-sql-kafka-0-10_2.11:2.3.0

standalone spark cluster不支持以--deploy-mode cluster来提交python程序, 只能后台运行
spark-submit --master spark://hadoop1:7077 --packages org.apache.spark:spark-sql-kafka-0-10_2.11:2.3.0  b.py &

"""


def main():
    spark = SparkSession.builder.getOrCreate()
    spark.conf.set("spark.sql.streaming.checkpointLocation", "checkpoint") # hdfs:///user/root/checkpoint


    df = spark.readStream.format("kafka").option("kafka.bootstrap.servers", "kafka1:9092,kafka2:9092,kafka3:9092").option("subscribe", "test").load()

    query = df.selectExpr("CAST(key AS STRING)", "CAST(value AS STRING)").writeStream.outputMode("append").format("parquet").option("path", "hdfs://hadoop1:9000/user/root/stream_out").start()
    query.awaitTermination()



if __name__ == '__main__':
    main()
