## 
nmap -v scanme.nmap.org

这个选项扫描主机scanme.nmap.org中 所有的保留TCP端口。选项-v启用细节模式。

nmap -sS -O scanme.nmap.org/24

进行秘密SYN扫描，对象为主机Saznme所在的“C类”网段 的255台主机。同时尝试确定每台工作主机的操作系统类型。因为进行SYN扫描 和操作系统检测，这个扫描需要有根权限。

nmap -sV -p 22，53，110，143，4564 198.116.0-255.1-127

进行主机列举和TCP扫描，对象为B类188.116网段中255个8位子网。这 个测试用于确定系统是否运行了sshd、DNS、imapd或4564端口。如果这些端口 打开，将使用版本检测来确定哪种应用在运行。

nmap -v -iR 100000 -P0 -p 80

随机选择100000台主机扫描是否运行Web服务器(80端口)。由起始阶段 发送探测报文来确定主机是否工作非常浪费时间，而且只需探测主机的一个端口，因 此使用-P0禁止对主机列表。

nmap -P0 -p80 -oX logs/pb-port80scan.xml -oG logs/pb-port80scan.gnmap 216.163.128.20/20

扫描4096个IP地址，查找Web服务器(不ping)，将结果以Grep和XML格式保存。

host -l company.com | cut -d -f 4 | nmap -v -iL -

进行DNS区域传输，以发现company.com中的主机，然后将IP地址提供给 Nmap。上述命令用于GNU/Linux -- 其它系统进行区域传输时有不同的命令。


nmap -A -T4  <ip>
