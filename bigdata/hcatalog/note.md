## Introduction
Hcatalog为hive自带的工具, 提供一个hcat命令, 无需进入hive交互式环境即可执行SQL  
使用Hive的metastore和DDL操作数据, 并为Pig, MapReduce提供操作接口  
Hcatalog作为Hive与其他工具交互的中间层, 通过内置的或自定义的serializer, de-serializer来支持RcFile, CSV, JSON, SequenceFile, ORC file等格式文件的读写  


## Glossary
```
HCatReader
HCatWriter
DataTransferFactory

HCatLoader 
HCatStorer
```
