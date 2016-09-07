create <tbname>, <column family>...
    create 'emp', 'personal data', 'professional data'

list: list table

disable <tbname>: disable table, can not scan 
enable <tbname>

describe <tbname>
    describe 'emp'

alter <tbname>
    alter 'emp', NAME ⇒ 'personal data', VERSIONS ⇒ 5
    alter 'emp', READONLY
    alter 'emp', 'delete'⇒'professional'
drop 'emp'
put '<table name>','row1','<colfamily:colname>','<value>'
put 'emp','1','personal data:name','raju' # insert or update

get 'emp', '1'
get 'emp', 'row1', {COLUMN ⇒ 'personal:name'}

delete 'emp', '1', 'personal data:city',
deleteall 'emp','1'

count 'emp'
scan 'emp'

truncate 'emp'

scan 'filemetadata', { COLUMNS => 'colFam:colQualifier', LIMIT => 10, FILTER => "ValueFilter( =, 'binaryprefix:<someValue.e.g. test1 AsDefinedInQuestion>' )" }

scan 'test', {COLUMNS => ['F'],FILTER => \ 
"(SingleColumnValueFilter('F','u',=,'regexstring:http:.*pdf',true,true)) AND \
(SingleColumnValueFilter('F','s',=,'binary:2',true,true))"}

grant 'username', 'table'
grant 'Tutorialspoint', 'RWXCA'
revoke 'table'
user_permission 'emp'


