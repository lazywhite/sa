pg_restore -d <dbname>  <backup-file-path>

-O: --no-owner      skip restoration of object ownership
-s: --schema-only   restore only the schema, no data
-C: --create        create the target database 
-c: --clean         clean database objects before recreating
-1: --single-transaction  restore as a single transaction
