## Introduction
```
Pig is a platform for analyzing large dataset that consists of a high-level  
language for expressing data analysis programs, coupled with infrastructure  
for evaluating these programs. The salient property of Pig program is that  
their structure is amenable to substantial parallelization, which in turn  
enables them to handle very large dataset  

Apache Pig is an abstraction over MapReduce. It is a tool/platform which is used to analyze larger sets of data representing them as data flows. Pig is generally used with Hadoop; we can perform all the data manipulation operations in Hadoop using Pig.

The language used to analyze data in Hadoop using Pig is known as Pig Latin. It is a highlevel data processing language which provides a rich set of data types and operators to perform various operations on the data.

To perform a particular task Programmers using Pig, programmers need to write a Pig script using the Pig Latin language, and execute them using any of the execution mechanisms (Grunt Shell, UDFs, Embedded). After execution, these scripts will go through a series of transformations applied by the Pig Framework, to produce the desired output.

**Pig Latin**: Pig's infrastructure layer compiler to produce sequnce of  
MapReduce programs  which has **ease of programming**, **optimization opportunities**  
**extensibility** properties

```

## Concept

### 1. Parser
Initially the Pig Scripts are handled by the Parser. It checks the syntax of the script, does type checking, and other miscellaneous checks. The output of the parser will be a DAG (directed acyclic graph), which represents the Pig Latin statements and logical operators.

In the DAG, the logical operators of the script are represented as the nodes and the data flows are represented as edges.

### 2. Optimizer
The logical plan (DAG) is passed to the logical optimizer, which carries out the logical optimizations such as projection and pushdown.

### 3. Compiler
The compiler compiles the optimized logical plan into a series of MapReduce jobs.

### 4. Execution engine
Finally the MapReduce jobs are submitted to Hadoop in a sorted order. Finally, these MapReduce jobs are executed on Hadoop producing the desired results.




