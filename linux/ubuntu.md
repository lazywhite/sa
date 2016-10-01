## 清空source缓存
rm -rf /var/lib/apt/lists/*

## 添加第三方源
/et/apt/sources.list.d/<third>.list


## 删除无依赖的包
apt-get autoremove

## 删除包和配置文件
apt-get purge <package>


## 查看某个文件属于哪个deb package
apt-get install apt-file
apt-file update
apt-file search <file-path>
