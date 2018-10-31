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

## Proxy
```
# ALL_PROXY=http://192.168.1.1:8888 brew install <>
```

## Usage
```
brew update # 升级brew本身及formulae列表
brew upgrade # 升级所有已安装formulae
brew upgrade [formulae]# 升级某个包

brew doctor # 诊断brew
brew config # 列出配置信息

brew info [formulae]
brew install -vd FORMULA # debug

HOMEBREW_NO_AUTO_UPDATE=1 brew install <formula> # 安装之前不更新
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

