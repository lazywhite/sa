export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_72.jdk/Contents/Home
export PATH=${JAVA_HOME}/bin:${PATH}
export HADOOP_CLASSPATH=${JAVA_HOME}/lib/tools.jar

rm -rf *.class
hadoop com.sun.tools.javac.Main AccessParser.java
jar cf AccessParser.jar Access*.class

hadoop jar AccessParser.jar AccessParser /user/white/in /user/white/parse_out
