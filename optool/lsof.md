lsof -n：不反解IP至HOSTNAME
lsof -i：用以显示符合条件的进程情况
lsof -i[46] [protocol][@hostname|hostaddr][:service|port]
	46：IPv4或IPv6
	protocol：TCP or UDP
	hostname：Internet host name
	hostaddr：IPv4地址
	service：/etc/service中的服务名称(可以不只一个)
	port：端口号 (可以不只一个)

[root@www ~]# lsof -i :22
COMMAND   PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
sshd     1390 root    3u  IPv4  13050      0t0  TCP *:ssh (LISTEN)
sshd     1390 root    4u  IPv6  13056      0t0  TCP *:ssh (LISTEN)
sshd    36454 root    3r  IPv4  94352      0t0  TCP www.test.com:ssh->172.16.0.1:50018 (ESTABLISHED)


上述命令中，每行显示一个打开的文件，若不指定条件默认将显示所有进程打开的所有文件。lsof输出各列信息的意义如下：
	COMMAND：进程的名称
	PID：进程标识符
	USER：进程所有者
	FD：文件描述符，应用程序通过文件描述符识别该文件。如cwd、txt等
	TYPE：文件类型，如DIR、REG等
	DEVICE：指定磁盘的名称
	SIZE：文件的大小
	NODE：索引节点（文件在磁盘上的标识）
	NAME：打开文件的确切名称

