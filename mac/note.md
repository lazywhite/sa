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

