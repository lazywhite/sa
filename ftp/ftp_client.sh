ftp -n <<EOF
open 1.4.6.8
user ftpuser pwd
binary
prompt
ls

put $file $dst_file

EOF
