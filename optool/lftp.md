交互式
lftp -p 21 ftp://ip -u user,pw
ftp> prompt # 不询问
ftp> binary # 二进制模式
ftp> mls <remote-dir> <local-save-path>
ftp> mget <file1> <file2> ...
ftp> mput <file1> <file2> ...
ftp> bye


脚本方式
lftp -p 21 ftp://ip -u user,pw <<EOF
prompt
binary
ls
bye
EOF
