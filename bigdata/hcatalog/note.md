## Introduction
使用Hive的metastore和DDL操作数据, 并为Pig, MapReduce提供操作接口    
hcat只能执行DDL语句, 不支持DML语句  
Hcatalog作为Hive与其他工具交互的中间层, 通过内置的或自定义的serializer, de-serializer来支持RcFile, CSV, JSON, SequenceFile, ORC file等格式文件的读写    


## Glossary
```
HCatReader
HCatWriter
DataTransferFactory

HCatLoader 
HCatStorer
```

## WebHcat
```
代号: Templeton
启动: sbin/webhcat_server.sh start
检测: curl -i http://localhost:50111/templeton/v1/status

```

