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




类rsync效果
source=/data
dest=/data
lftp -u user,password 10.225.2.7<<EOF
lcd $source
cd $dest
mirror -R -e -c --only-newer --only-missing 
bye
EOF


当put目的文件夹不存在时, 会报错并上传到家目录

mirror 
    -P 30 # 并发数, 默认为1
    -c  # 继续上一次的mirror job


mirror -v -c -P 50 -R /data/mrbushu  /gpfs/mrbs 
    将本地文件夹同步至远程ftp, 目录位置需要对调
