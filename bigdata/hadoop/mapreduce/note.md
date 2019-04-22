## MapReduce术语
Tuple
	key, value pair
	
Input Phase 
	从HDFS读取数据, 将数据拆分为tuple发送给mapper
		
Output Phase 
	将reducer产生的final tuple由output formatter进行格式化后写入HDFS

Map Function
	用户自定义函数, 将输入tuple进行转化 
	
Reduce Function
	用户自定义函数, 将输入的grouped tuple进行过滤, 聚合
	
Mapper
	将map function应用在tuple上, 产生intermediate keys

Intermediate Keys
	由mapper生成的tuple
	
Combiner 
	将intermediate key进行初步组合, 产生grouped tuple

Reducer
	1. Shuffle and Sort  将需要处理的grouped tuple下载到本地并进行排序
	2. 将reduce function应用在tuple上



hadoop job -list [all]
hadoop job -kill <job_id>
