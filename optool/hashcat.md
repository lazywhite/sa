默认GPU, CPU支持需要安装OpenCL runtime
download: https://hashcat.net/hashcat/


hashcat [options]... hash|hashfile|hccapxfile [dictionary|mask|directory]...
    -m: mode(md5, mysql, wpa etc..)
    -r: rule

HASH=$(echo 'Password1'|md5sum|tr -d ' -')
hashcat -m 0 $(HASH) example.dict  --potfile-path=output.pot --show

hashcat -m 300 -a 0 -r rules/d3ad0ne.rule hash rockyou.txt

