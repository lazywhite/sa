docker pull rallyforge/rally

mkdir /root/volume
chown 65500 /root/volumn

echo >>~/.bashrc <<EOF
alias wrally="docker run -it --rm -v /root/volumn:/home/rally rally"
EOF

wrally

source openrc
rally-manage db recreate
rally deployment create --name="dev" --fromenv
rally deployment use "dev"
rally deployment check
rally task start /path/to/boot-and-delete.json
rally task report <task-uuid> --out boot-and-delete.html


rally verify create-verifier --type tempest --name tempest-verifier --version 15.0.0
rally verify list-verifiers
rally verify show-verifier
rally verify use-verifier

rally verify configure-verifier # 按照当前deployment config配置verifier
rally verify configure-verifier --show # 显示生成的配置


rally verify start
rally verify start --pattern set=compute

rally verify delete-verifier --id=207763bc-2001-40f5-b08d-68381f6e923c --force
