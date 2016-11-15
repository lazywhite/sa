## Transformations
```
map(func): return a new distributed dataset formed by passing each element of 
        the source through a function "func"
flatMap(func): 
filter(func): return a new dataset formed by selecting those elements of the 
            source on which "func" returns

mapPartitions(func): similar to map() but runs separately on each partition(block)
            of RDD, so func must be of type Iterator<T> => Iterator<U> when running
            on an RDD of type T

mapPartitionsWithIndex(func):
sample(withRepalcement, fraction, seed): sample a fraction "fraction" of the data
                using a given random number generator seed

union(otherDataset): return a new dataset that contains the union of the elements
            in the source dataset and the argument

intersetction(otherDataset)
distinct([numTasks]): return a new dataset that contains the distinct elements
                of the source dataset


groupByKey([numTasks]): when called on a dataset of (K, V) pairs, return a dataset
            of (K, Iterable<V>) pairs
reduceByKey(): when called on a dataset of (K, V) pairs, return a dataset of (K, V)
            pairs where the values for each key are aggregated using the given 
            reduce function "func", which must be type of (V, V) => V

aggregateByKey(zeroValues)(seqOp, combOp, [numTasks]):
sortByKey([ascending], [numTasks]): when called on a dataset of (K, V) pairs where
            K implements Ordered, returns a dataset of (K, V) pairs sorted by keys
            in ascending or descending order. 

join(otherDataset, [numTasks]): when called on datasets of type(K, V) and (K, W)
            return a dataset of (K, (V, W)) pairs with all pairs of elemenets for
            each key

cogroup(otherDataset, [numTasks])

cartesian(otherDataset):

pip(command, [envVars]:
coalesce(numPartitions)

repartition(numPartitions):

repartitionAndSortWithinPartitions(partitions)
```

## Actions
```
reduce()
collect()
count()
first()
task(n)
takeSample()
taskOrdered
saveAsTextFile()
saveAsSequenceFile()
saveAsObjectFile()
countByKey()
foreach(func)
```


## Shuffle Operation
## RDD persistence

