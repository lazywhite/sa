```
mongodump  <options>
    --host==
    --port==
    --username=
    --password=
    --db=<dbname>
    --collection=<collection_name>
    --database==
    --archive==
    --gzip
    [--out==]


mongorestore <options> <direcotry or file to restore>
    --gzip: decompress gzipped input
    --archive=<filename>: restore dump from  archive file
    --drop: drop each collection before import
    --noIndexRestore: don't restore indexes
    --noOptionsRestore: don't restore collection options
    -j, --numParallelCollections=<number>: number of collections to restore
                                            in parallel
    --stopOnError: stop restoring if an error is encountered on insert
 
mongoexport <options>
    --host=
    --port=
    --username=
    --password=
    --db=
    --collection=
    --out=<filename>
    -q, --query=<json>: query filter
    --skip=<count>
    
mongoimport <option> <file>
    --host=
    --port=
    --username=
    --password=
    --db=
    --collection=
    --out=<filename>
    --drop : drop collection before inserting
```
