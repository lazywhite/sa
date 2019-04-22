## 安装特定版本
```
apt-get install package=version
```
## 清空source缓存
```
Hash Sum mismatch

rm -rf /var/lib/apt/lists/*
```

## 添加第三方源
```
/et/apt/sources.list.d/<third>.list
```
## 搜索包
```
apt-cache search <package>
```
## 删除包
```
apt-get remove <package>
```


## 删除无依赖的包
```
apt-get autoremove
```

## 删除包和配置文件
```
apt-get purge <package>
```


## 查看某个文件属于哪个deb package
```
apt-get install apt-file
apt-file update
apt-file search <file-path>
```


## dpkg
```
dpkg -i /path/to/file.deb
dpkg -r <package>
dpkg -l # 列出所有包
dpkg -L <package> # 列出文件列表
```
