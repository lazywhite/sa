# <center> PgSQL partition table usage

## 1. create partion table
``` 
 CREATE TABLE almart
(
	date_key date,
	hour_key smallint,
	client_key integer,
	item_key integer,
	account integer,
	expense numeric
);
```
## 2. create child tables
```

create table almart_2016_10_19 () inherits (almart);
create table almart_2016_10_20 () inherits (almart);
create table almart_2016_10_21 () inherits (almart);
create table almart_2016_10_22 () inherits (almart);
```
## 3. create constraint and index on child tables

```
ALTER TABLE almart_2016_10_19
ADD CONSTRAINT almart_2016_10_19_check_date_key
CHECK (date_Key = '2016-10-19'::date);

ALTER TABLE almart_2016_10_20
ADD CONSTRAINT almart_2016_10_20_check_date_key
CHECK (date_Key = '2016_10_20'::date);


ALTER TABLE almart_2016_10_21
ADD CONSTRAINT almart_2016_10_21_check_date_key
CHECK (date_Key = '2016-10-21'::date);

ALTER TABLE almart_2016_10_22
ADD CONSTRAINT almart_2016_10_22_check_date_key
CHECK (date_Key = '2016_10_22'::date);


CREATE INDEX almart_date_key_2016_10_19
ON almart_2016_10_19 (date_key);



CREATE INDEX almart_date_key_2016_10_20
ON almart_2016_10_20 (date_key);


CREATE INDEX almart_date_key_2016_10_21
ON almart_2016_10_21 (date_key);


CREATE INDEX almart_date_key_2016_10_22
ON almart_2016_10_22 (date_key);


```

## 3. create insert trigger
```

CREATE OR REPLACE FUNCTION almart_partition_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.date_key = DATE '2016-10-19'
    THEN
        INSERT INTO almart_2016_10_19 VALUES (NEW.*);
    ELSIF NEW.date_key = DATE '2016-10-20'
    THEN
        INSERT INTO almart_2016_10_20 VALUES (NEW.*);
    ELSIF NEW.date_key = DATE '2016-10-21'
    THEN
        INSERT INTO almart_2016_10_21 VALUES (NEW.*);
    ELSIF NEW.date_key = DATE '2016-10-22'
    THEN
        INSERT INTO almart_2016_10_22 VALUES (NEW.*);
    ELSIF NEW.date_key = DATE '2016-10-23'
    THEN
        INSERT INTO almart_2016_10_23 VALUES (NEW.*);
    END IF;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;


CREATE TRIGGER insert_almart_partition_trigger
BEFORE INSERT ON almart
FOR EACH ROW EXECUTE PROCEDURE almart_partition_trigger();
```

## 4. create non-partition table 

```
CREATE TABLE almart_all
(
	date_key date,
	hour_key smallint,
	client_key integer,
	item_key integer,
	account integer,
	expense numeric
);

```

## 5. create random generated data
```
INSERT INTO
	almart_all
select
	(select
		array_agg(i::date)
	from
		generate_series(
		'2016-10-19'::date,
		'2016-10-22'::date,
		'1 day'::interval) as t(i)
	)[floor(random()*4)+1] as date_key,
	floor(random()*24) as hour_key,
	floor(random()*1000000)+1 as client_key,
	floor(random()*100000)+1 as item_key,
	floor(random()*20)+1 as account,
	floor(random()*10000)+1 as expense
from
	generate_series(1,3000000,1);


```
## 6. copy data to partition table
```
insert into almart select * from almart_all

```

## 7. compare select  performance
```

\timing  # open sql execution timing


select avg(expense) from (select client_key, sum(expense) as expense from almart_all where date_key = date '2016-10-20' group by 1) as f;

 select avg(expense) from (select client_key, sum(expense) as expense from almart where date_key = date '2016-10-20' group by 1) as f;

```

## 8. enable auto created child table
```

CREATE OR REPLACE FUNCTION almart_partition_trigger()
RETURNS TRIGGER AS $$
DECLARE date_text TEXT;
DECLARE insert_statement TEXT;
BEGIN
	SELECT to_char(NEW.date_key, 'YYYY_MM_DD') INTO date_text;
	insert_statement := 'INSERT INTO almart_'
		|| date_text
		||' VALUES ($1.*)';
	EXECUTE insert_statement USING NEW;
	RETURN NULL;
	EXCEPTION
	WHEN UNDEFINED_TABLE
	THEN
		EXECUTE
			'CREATE TABLE IF NOT EXISTS almart_'
			|| date_text
			|| '(CHECK (date_key = '''
			|| date_text
			|| ''')) INHERITS (almart)';
		RAISE NOTICE 'CREATE NON-EXISTANT TABLE almart_%', date_text;
		EXECUTE
			'CREATE INDEX almart_date_key_'
			|| date_text
			|| ' ON almart_'
			|| date_text
			|| '(date_key)';
		EXECUTE insert_statement USING NEW;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;



test=# insert into almart (date_key, expense) values ('2016-10-23', 101010);
NOTICE:  CREATE NON-EXISTANT TABLE almart_2016_10_23
INSERT 0 0
Time: 26.761 ms

```



