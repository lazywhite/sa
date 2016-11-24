## Installation
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
## Speedup
```
cd /usr/local/Homebrew
git remote set-url origin git://mirrors.ustc.edu.cn/brew.git
brew update
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.bash_profile
source ~/.bash_profile
```

## Services tap
```
brew tap homebrew/services
```

## Formula

```
desc
homepage
url # replace this with file_path to installed from local, version involved
mirror
sha256  # 

```



## Distribute
```
brew create https://test.local.com/bar-1.1.tar.gz
```

## Edit  
```
brew edit wget

```
