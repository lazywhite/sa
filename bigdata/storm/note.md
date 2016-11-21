## Introduction

特点: 分布式实时处理, 与语言无关
## Keyword
```
Tuple
    main data structure in storm, it is a list of ordered elements, By default a Tuple supports all data types

Stream
    an unordered sequence of tuples

Spouts
    source of stream

Bolts
    logical processing units

"Spouts" pass data to bolts and bolts process and produce a new output stream
"ISpouts" is the core interface for implementing spouts
"Bolts" can perform the operations of filtering, aggregation, joining, interacting
with data sources and databases, bolts receives data and emits to one or more bolts
"IBolts" is the core interface for implementing bolts


Tasks

Workers
Stream Grouping
    shuffle grouping
    field grouping
    global grouping
    all grouping
```
## Cluster Components
```
Nimbus
Supervisor
Worker process
Executor
Task
Zookeeper framework
```
