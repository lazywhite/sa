## Authentication
Authentication in InfluxDB is disabled by default

## Chunk Size
For large queries, results are returned in batches of 10,000 points unless you use the query string parameter chunk_size to explicitly set the batch size  

```
curl -G 'http://localhost:8086/query' --data-urlencode "db=deluge" --data-urlencode "chunk_size=20000" --data-urlencode "q=SELECT * FROM liters"
```


## Schema design
In the 0.9.x version of InfluxDB, it is recommended that you encode most metadata into the series Tags. Tags are indexed within the InfluxDB system allowing fast querying by 1 or more tag values. Note that tag values are always interpreted as strings. 



## Timezone
currently influxdb only support UTC

## Duplicate point
A point is uniquely identified by the measurement name, tag set, and timestamp. If you submit Line Protocol with the same measurement, tag set, and timestamp, but with a different field set, the field set becomes the union of the old field set and the new field set, where any conflicts favor the new field set.


## Query language
```
1. Getting series with special characters

    select * from "series with special characters!" # double quota series name
    select * from "series with \"double quotes\""  # translate 


2. Query by time
    datetime string 
        '2013-08-12 23:32:01.232' 
        '2013-08-13'
    relative time
        now() - 1h
    absolute time
        1388534400s

3. query specific point
    Points are uniquely identified by the time series they appear in, the time, and the sequence number. 

4. select multiple series
    select * from events, errors

5. deleting data or  dropping series
    With no time constraints this query will delete every point in the time series response_times. You must be a cluster or database admin to run delete queries
    delete from response_times where time < now() - 1h

6. "where" clause
7. "group by" clause
    1. not only used for grouping by given value, also used for grouping by given time buckets 

        select count(usage_guest) as usage_guest_count from cpu where time > now() - 1h group by time(15m);

    2. fill must go at the end of the group by clause if there are other arguments:
        select count(type) from events group by time(1h) fill(-1|0|null) where time > now() - 3h

8. "merging"
    1. merge multiple time series into one stream, this is helpful when you want to run a function over one of the columns
    with an associated group by clause

    select count(type) from user_events merge admin_events group by time(10m)

9. "joining"
    1. Joins will put two or more series together. Since timestamps may not match exactly, InfluxDB will make a best effort to put points together. Joins are used when you want to perform a transformation of one time series against another
        
    select hosta.value + hostb.value
    from cpu_load as hosta
    inner join cpu_load as hostb
    where hosta.host = 'hosta.influxdb.orb' and hostb.host = 'hostb.influxdb.org';
    
```

## Continuous query
When writing in large amounts of raw data, you will often want to query a downsampled variant of the data for viewing or analysis. In some cases, this downsampled data may be needed many times in the future, and repeatedly computing the same rollups is wasteful. Continuous queries let you precompute these expensive queries into another time series in real-time


Continuous queries are created when you issue a select statement with an into clause. Instead of returning the results immediately like a normal select query, InfluxDB will instead store this continuous query and run it periodically as data is collected. Only cluster and database admins are allowed to create continuous queries.


### Fanout query
Fanout queries work as a kind of index
