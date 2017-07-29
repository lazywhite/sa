## Installation
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
## Speedup
```
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.bash_profile
source ~/.bash_profile
```

## Tap

```
brew tap beeftornado/rmtree  # 递归删除某个formula及其依赖
brew rmtree <formula>
```

## Formula

```
格式
    desc
    homepage
    url # replace this with file_path to installed from local, version involved
    mirror
    sha256  # 

编辑
    brew edit <formula>
```


## Distribute
```
brew create https://test.local.com/barbar-1.1.tar.gz # 要事先存在
brew edit barbar
```

