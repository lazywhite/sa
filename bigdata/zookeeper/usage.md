## Installation
```
brew install zookeeper
brew services start zookeeper

zoo.cfg
```
## Usage
```
zkCli -server localhost:2181 // 支持自动补全
>help 显示帮助
>create /father first   //创建node
>get /father  //获取node data及node property

>create /father/child01 "child01 first"   //创建持久node
>create -s /father/child02 "first"  //创建sequential node
>create -e /father/child03 "first" //创建ephemeral node

>ls /father  //列出节点子节点
>ls2 /father  //列出所有子节点和自身property
>stat /father //列出节点状态
>set /father "second" [version]//重新赋值, verion不省略必须与stat得到的dataVersion相同
>delete /father/child01 //删除无子节点的节点
>rmr /father 递归删除

>close //关闭本地连接
>connect localhost:2181 //连接其他zookeeper server
>quit //退出cli

>setAcl /father  ip:127.0.0.1:crwda //设置权限
>getAcl /father //获取权限

>listquota /father  //获取node限额
>setquota -n 4 | -b 1024  /father //设置node限额
>delquota /father //删除限额

>history //命令历史记录
```

## Node property
```
zxid: zookeeper transaction id, zookeeper是有序的, 保证后续发生
事务的id一定大于之前的事务
cZxid
    创建时间对应的zxid
ctime
mZxid
    更新时间对应的zxid
mtime
pZxid
    该节点或其子节点最近一次发生修改的zxid, 与孙节点无关
cversion
    子节点数据版本
dataVersion
    数据版本
aclVersion
    权限控制版本
ephemeralOwner
    临时节点的owner id
dataLength
    node data长度
numChildren
    子节点数目
```
## zookeeper_browser
```
git clone https://github.com/mijalko/zookeeper_browser.git
pip install -r requirements.txt
python zkbrowser.py
```



