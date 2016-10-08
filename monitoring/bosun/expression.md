## Introduction
Bosun's expression language is used to define the trigger condition for an alert  The expression language takes various time "series" and reduces them into a single number, True or false indicates whether the alert should trigger or not; 0 represents false \(don't trigger an alert\) and other number represents true \(trigger  an alert\), an alert can also produce one or more groups which define the alert's scope or dimensionality
for exmaple could you have one alert per host, service, or cluster or a single alert for your entire environment

## Issue
{} is still a group  

## Data Types
1. Scalar: a single numeric value with no group associated  
2. NumberSet: a group of tagged numeric values with one value per unique grouping   
    a "scalar" may be used in place of a "numberSet" with a single member with  an empty group
3. SeriesSet: an array of timestamp-value pairs and an associated group

in the vast majority of your alert you will getting "seriesSets" back from your time series database and "reducing" them into "numberSets"


## Group keys
groups are generally provided by your timestamp series database, we also sometimes
refer to groups as 'tags', when you query your time series database and get muliple  
time series back, each time series needs an identifier. So for example if I make   
a query with something like "host=\*", then I will get one time series per host  
host is the tag key, and the various values returned, ie "host1, host2, host3..."  
are the tag values, therefore the group for a single time series is something like  
"{host=host1}", A group can have multiple tag keys, and will have one tag value  
for each key

each group can become its own alert instance, This is what we mean by "scope" or 
"dimensionality" Thus you can do things like 'avg(q("sum:sys.cpu{host=ny-\*}","5m","")) > 0.8' to check the CPU usage for many New-York hosts at once, the dimensions can  be manipulated with our expression language

## Group subsets
various metrics can be combined by operators as long as one group is a subset of the  other, A "Subset" is when one of the groups contains all of the tag key-value pairs  
An empty group '{}' is a subset of all groups 

## Operator
```
+ - * / %
< > == != >= <=
&& || !
```
## Series Operations
if you combine two seriesSet with an operator 'q() + q()' then operations are applied for each point in the series if there is a corresponding datapoint on the  right hand sde

## Influx Query Functions
```
influx(db string, query string, startDuration string, endDuration string, groupByInterval string) seriesSet
```

### Notes
1. by default queries will be given a suffix of "fill(none)" to filter out any nil rows
2. influx queries themselves often use both double and single quotes, So you will 
likely need to use triple single quotes ''' for many queries 
when using single quotes in triple single quotes, you may need a space. 


## Reduction Functions
1. avg(seriesSet) numberSet

2. cCount(seriesSet) numberSet
3. dev(seriesSet) numberSet
4. diff(seriesSet) numberSet
5. first(seriesSet) numberSet
6. forecastlr(seriesSet, y_val numberSet|scalar) numberSet
7. linelr(seriesSet, d Duration) seriesSet
8. last(seriesSet) numberSet
9. len(seriesSet) numberSet
10. max(seriesSet) numberSet
10. median(seriesSet) numberSet
10. min(seriesSet) numberSet
10. percentile(seriesSet) numberSet
10. since(seriesSet) numberSet
10. streak(seriesSet) numberSet
10. sum(seriesSet) numberSet

## Group Functions
```
t(numberSet, group string) seriesSet
ungroup(numberSet) scalar
```

## Other Functions
```
alert(name string, key string) numberSet

abs(numberSet) numberSet
d(string) scalar
tod(scalar) string
des(series, alpha scalar, beta scalar) series
dropg(seriesSet, threshold numberSet|scalar) seriesSet
dropge(seriesSet, threshold numberSet|scalar) seriesSet
dropl(seriesSet, threshold numberSet|scalar) seriesSet
drople(seriesSet, threshold numberSet|scalar) seriesSet
dropna(seriesSet) seriesSet
dropbool(seriesSet, seriesSet) seriesSet
epoch() scalar
filter(seriesSet, numberSet) seriesSet
limit(numberSet, count scalar) numberSet
lookup(table string, key string) numberSet
lookupSeries(series seriesSet, table string, key string) numberSet
month(offset scalar, startEnd string) scalar
series(tagset string, epoch, value, …) seriesSet
shift(seriesSet, dur string) seriesSet
merge(SeriesSet…) seriesSet
nv(numberSet, scalar) numberSet
rename(seriesSet, string) seriesSet
sort(numberSet, (asc|desc) string) numberSet
timedelta(seriesSet) seriesSet
```

## Topic
1. env variable  
2. cannot acknowledge closed alert  

