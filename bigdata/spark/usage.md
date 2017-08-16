## input file
```
people are not as beautiful as they look,
as they walk or as they talk.
they are only as beautiful  as they love,
as they care as they share.
```

## code
```
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark._

object SparkWordCount {
   def main(args: Array[String]) {

      val sc = new SparkContext( "local", "Word Count", "/usr/local/spark", Nil, Map(), Map())

      /* local = master URL; Word Count = application name; */
      /* /usr/local/spark = Spark Home; Nil = jars; Map = environment */
      /* Map = variables to work nodes */
      /*creating an inputRDD to read text file (in.txt) through Spark context*/
      val input = sc.textFile("in.txt")
      /* Transform the inputRDD into countRDD */

      valcount = input.flatMap(line ⇒ line.split(" "))
      .map(word ⇒ (word, 1))
      .reduceByKey(_ + _)

      /* saveAsTextFile method is an action that effects on the RDD */
      count.saveAsTextFile("outfile")
      System.out.println("OK");
   }
}
```

## compile
```
scalac -classpath "spark-core_2.10-1.3.0.jar:/usr/local/spark/lib/spark-assembly-1.4.0-hadoop2.6.0.jar" SparkPi.scala
```

## package 
```
jar -cvf wordcount.jar SparkWordCount*.class spark-core_2.10-1.3.0.jar/usr/local/spark/lib/spark-assembly-1.4.0-hadoop2.6.0.jar
```

## run
```
spark-submit --class SparkWordCount --master local wordcount.jar
```
## dashboard
```
http://localhost:4040
```
