Data control language, a set of SQL statements for managing privileges. In MySQL, consists of the GRANT and REVOKE statements. 
Data manipulation language, a set of SQL statements for performing insert, update, and delete operations. 

A procedure is invoked using a CALL statement (see Section 13.2.1, “CALL Syntax”), and can only pass back values using output variables. A function can be called from inside a statement just like any other function (that is, by invoking the function's name), and can return a scalar value.
A stored procedure or function is associated with a particular database
When a database is dropped, all stored routines associated with it are dropped as well.


Within the trigger body, the OLD and NEW keywords enable you to access columns in the rows affected by a trigger. OLD and NEW are MySQL extensions to triggers; they are not case sensitive.

A column named with OLD is read only. You can refer to it (if you have the SELECT privilege), but not modify it

MySQL Events are tasks that run according to a schedule. Therefore, we sometimes refer to them as scheduled events

User variables are written as @var_name, where the variable name var_name consists of alphanumeric characters, “.”, “_”, and “$”. A user variable name can contain other characters if you quote it as a string or identifier (for example, @'my-var', @"my-var", or @`my-var`).

User-defined variables are session-specific. A user variable defined by one client cannot be seen or used by other clients
All variables for a given client session are automatically freed when that client exits.

User variable names are not case sensitive.
For SET, either = or := can be used as the assignment operator.

You can also assign a value to a user variable in statements other than SET. In this case, the assignment operator must be := and not = because the latter is treated as the comparison operator = in non-SET statements:

The DECLARE statement is used to define various items local to a program:


To deallocate a prepared statement produced with PREPARE, use a DEALLOCATE PREPARE statement that refers to the prepared statement name. Attempting to execute a prepared statement after deallocating it results in an error.

keyword return is only used in Function not procedure

keyword are case insensitive
can be used as calculator
enter multiple-statement on a single line, seperate with semicolon;
multi-line statement;
\c cancel the query
interpreter has 6 prompot type
text-file   \N (NULL),  column seperate by \t
mysql> LOAD DATA LOCAL INFILE '/path/pet.txt' INTO TABLE pet  LINES TERMINATED BY '\r\n';
Mac with '\r'; must have local file capability enabled
String comparisons normally are case-insensitive
AND and OR may be mixed
NULL is a special value that cannot be compared using the usual comparison operators.
where death IS NOT NULL
mysql> select month(date_add(curdate(), interval 1 month));
0 or NULL means false and anything else means true. The default truth value from a boolean operation is 1
it is entirely possible to insert a zero or empty string into a NOT NULL column
To find names containing exactly five characters, use five instances of the “_” pattern character
If you really want to force a REGEXP comparison to be case sensitive, use the BINARY keyword to make one of the strings a binary string.
SELECT * FROM pet WHERE name REGEXP '^.....$'; (match five characters)
SELECT * FROM pet WHERE name REGEXP '^.{5}$';

 Number of animals per combination of species and sex:
 mysql> SELECT species, sex, COUNT(*) FROM pet GROUP BY species, sex;
 If you want to get the interactive output format in batch mode, use mysql -t. To echo to the output the commands that are executed, use mysql -vvv.

 SELECT MAX(article) AS article FROM shop;
 SELECT article, dealer, price FROM   shop WHERE  price=(SELECT MAX(price) FROM shop);
 SELECT article, MAX(price) AS price
 FROM   shop
 GROUP BY article;

  ALTER TABLE tbl AUTO_INCREMENT = 100;

   general query log file default name is host_name.log.

   running multiple instances on one machine

   Server SQL modes define what SQL syntax MySQL should support and what kind of data validation checks it should perform. This makes it easier to use MySQL in different environments and to use MySQL together with other database servers

   The Thread Pool plugin provides an alternative thread-handling model designed to reduce overhead and improve performance.

   If the value of a user variable is selected in a result set, it is returned to the client as a string.
   If you refer to a variable that has not been initialized, it has a value of NULL and a type of string.
   the order of evaluation for expressions involving user variables is undefined.
   the default result type of a variable is based on its type at the start of the statement

   A prepared statement is specific to the session in which it was created
   If you terminate a session without deallocating a previously prepared statement, the server deallocates it automatically.


   ## Mysql 5.7.9
   mysqld --initialize[-insecure]
   random-password-file=$HOME/.mysql_secure or in /var/log/mysqld.log


   mysql> set password for 'root'@'localhost'  =  Password('bbbb');
   mysql> alter user 'root'@'localhost' identified by 'hehe';
   mysql> LOCK TABLES t1 READ;

