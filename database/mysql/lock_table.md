## topics
1. use "KILL" to terminate a session that is waiting for a table lock
2. "LOCK TABLES" and "UNLOCK TABLES" cannot be used within stored programs
3. tables in "performance schema" database cannot be locked, except the "setup_xxx" tables
4. 


## Usage
```
LOCK TABLES t1 WRITE, t2 READ;
```
