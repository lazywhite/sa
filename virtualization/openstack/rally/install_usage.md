docker pull rallyforge/rally

mkdir /root/volume
chown 65500 /root/volumn

echo >>~/.bashrc <<EOF
alias wrally="docker run -it --rm -v /root/volumn:/home/rally rally"
EOF

# 开启远程ssh
docker run -d -p 8022:22 -v ~/rally_container:/home/rally rally sudo /usr/sbin/sshd -D

# 可以在rally_container里面编辑文件
ssh -p 8022 rally@ip   #123456

bash --login

source openrc
rally-manage db recreate

rally deployment create --name="dev" --fromenv

rally deployment create --name="dev" --file env.json
. ~/.rally/openrc #可以使用openstack命令

rally deployment config # 查看当前环境

# rally deployment use "dev" # 指定被测的os集群
rally deployment check

rally task start /path/to/boot-and-delete.json
rally task report <task-uuid> --out output.html

rally task results <task-uuid> # 生成task的json格式结果


rally verify create-verifier --type tempest --name tempest-verifier --version 15.0.0
rally verify list-verifiers
rally verify show-verifier
rally verify use-verifier

rally verify configure-verifier # 按照当前deployment config配置verifier
rally verify configure-verifier --show # 显示生成的配置


rally verify start
rally verify start --pattern set=compute

rally verify delete-verifier --id=207763bc-2001-40f5-b08d-68381f6e923c --force


# task配置文件
times: 指总的测试次数
concurrency: 指并发数
times要大于等于concurrency
