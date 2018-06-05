Transformation
    map(func): 针对每个element将一个长度为N的DataSet转换为另一个长度为N的DataSet
    flatMap(func): 将一个长度为N的DataSet转化为一个N个元素的集合, 再将N个元素合并成单个DataSet
    filter(func): func返回Boolean
    mapPartitions(func): 针对每个block
    sample(withReplacement, fraction, seed)
    union(otherDataset): 合集
    intersection(otherDataset): 交集
    distinct([])
    groupByKey()
    reduceByKey()
    join(otherDataset, [])
    cogroup(otherDataset, [])
    repartition(numPartitions)


Action
    reduce(func): func接受两个参数返回一个结果
    collect(): 将所有element收集到driver program, 有可能会内存溢出, 
    take(n): 返回前n个element
    count(): 返回所有element的个数
    cache(): 缓存dataset, cluster-wide in-memory
    first(): 返回第一个element, 类似于take(1)

    countByKey(): 仅适用于(k, v), 返回(k, Count)的HashMap
    foreach(func): 一般用来更新accumulator


pyspark.sql.functions
    collect_set
    collect_list
    concat_ws
