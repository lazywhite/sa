## Authentication
Authentication in InfluxDB is disabled by default

## Chunk Size
For large queries, results are returned in batches of 10,000 points unless you use the query string parameter chunk_size to explicitly set the batch size
```
curl -G 'http://localhost:8086/query' --data-urlencode "db=deluge" --data-urlencode "chunk_size=20000" --data-urlencode "q=SELECT * FROM liters"
```


## Schema design
In the 0.9.x version of InfluxDB, it is recommended that you encode most metadata into the series Tags. Tags are indexed within the InfluxDB system allowing fast querying by 1 or more tag values. Note that tag values are always interpreted as strings. 

