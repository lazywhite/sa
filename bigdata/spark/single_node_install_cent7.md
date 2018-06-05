# install jdk
# install hadoop
# install scala(可选)
wget https://downloads.lightbend.com/scala/2.12.4/scala-2.12.4.rpm
rpm -ivh scala.rpm
# install spark

根据hadoop版本, 选择预编译tgz文件
wget http://mirrors.tuna.tsinghua.edu.cn/apache/spark/spark-2.2.0/spark-2.2.0-bin-hadoop2.7.tgz

tar xf spark-2.2.0-bin-hadoop2.7.tgz 
mv spark-2.2.0-bin-hadoop2.7  /usr/local/spark
export PATH=/usr/local/spark/bin:/usr/local/spark/sbin:$PATH
export SPARK_HOME=/usr/local/spark

