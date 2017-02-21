#!/bin/bash
export PATH=/opt/mssql-tools/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
export WD=/home/sqlserver_backup

HOST='localhost'
USER='sa'
PASSWD='passwd'

function dump_db (){
        file_dir=${WD}/${1}
        now=`date +%F-%H-%M`
        rmday=`date --date="-6 day" +%F`

        backfile=${file_dir}/$1-$now.back
        rmfile_pattern=${file_dir}/$1-$rmday.*
        if [ ! -e ${file_dir} ];then
                mkdir ${file_dir}
                chown -R mssql:mssql ${file_dir}
        fi
        rm -f ${rmfile_pattern}
        sqlcmd -H ${HOST} -U${USER} -P${PASSWD} -Q "BACKUP DATABASE $1 TO disk=\"${file_dir}/$1-$now.db\""
}


dump_db Book
