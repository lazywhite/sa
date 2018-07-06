## system pip install  operation not permitted
```
sudo pip install --ignore-installed libipa
```
##  iterm2 start too slow
```
sudo rm /private/var/log/asl/*.asl
```

## get xcode version
```
xcodebuild -version
```

## build a project
```
xcodebuild clean archive -project <path_to_project_dir> -scheme <scheme_name>  
```

## show full path in finder
```
defaults write com.apple.finder _FXShowPosixPathInTitle -bool TRUE;killall Finder
defaults delete com.apple.finder _FXShowPosixPathInTitle;killall Finder
```
## 占用较大空间的缓存文件夹
```
~/Library/Developer/Xcode/iOS DeviceSupport
```

## set ls output color
```
export CLICOLOR=1
LSCOLORS=ExFxCxDxBxegedabagacad
```


## GVim set font size
```
set guifont=Monaco:h12
```


## set user loggin shell
```
chpass -u white -s /usr/local/bin/zsh
```
## get mac version
```
sw_vers -productVersion:  10.11.6
system_profiler SPSoftwareDataType

Software:

    System Software Overview:

      System Version: OS X 10.11.6 (15G1004)
      Kernel Version: Darwin 15.6.0
      Boot Volume: MacBook
      Boot Mode: Normal
      Computer Name: MacPro
      User Name: white (white)
      Secure Virtual Memory: Enabled
      System Integrity Protection: Enabled
      Time since boot: 9 days 19:35
```

## install lxml

```
brew install libxml2
brew install libxslt
brew link libxml2 --force
brew link libxslt --force
sudo C_INCLUDE_PATH=/usr/local/include/libxml2 pip install lxml
```
## dd 过慢问题
```
dd if=Downloads/FreeBSD-10.1-RELEASE-amd64-memstick.img of=/dev/rdisk2 bs=1024000
```

## 禁止开机启动
```
sudo launchctl unload /Library/LaunchDaemons/com.alipay.DispatcherService.plist 
```

## install telnet
```
brew install inetutils
```

```
command not found : glibtoolize
    brew install libtool
command not found : aclocal
    brew install automake
```
