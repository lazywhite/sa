CREATE OR REPLACE FUNCTION stock_move_partition_trigger()
RETURNS TRIGGER AS $$
DECLARE date_text TEXT;
DECLARE insert_statement TEXT;
BEGIN
	SELECT to_char(NEW.create_date, 'YYYY_MM_DD') INTO date_text;
	insert_statement := 'INSERT INTO stock_move_'
		|| date_text
		||' VALUES ($1.*)';
	EXECUTE insert_statement USING NEW;
	RETURN NULL;
	EXCEPTION
	WHEN UNDEFINED_TABLE
	THEN
		EXECUTE
			'CREATE TABLE IF NOT EXISTS stock_move_'
			|| date_text
			|| '(CHECK (to_char(create_date, ''YYYY_MM_DD'') = '''
			|| date_text
			|| ''')) INHERITS (stock_move)';
		RAISE NOTICE 'CREATE NON-EXISTANT TABLE stock_move_%', date_text;
		EXECUTE
			'CREATE INDEX stock_move_create_date_'
			|| date_text
			|| ' ON stock_move_'
			|| date_text
			|| '(create_date)';
		EXECUTE insert_statement USING NEW;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

