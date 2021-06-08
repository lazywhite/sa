## Window
```
一个window是一个buffer的展示点, 新打开的window可以访问之前window的所有buffer

^+w n: 打开一个新窗口, 默认在当前窗口之上, 占半屏高度, 编辑空文件
^+w o: 关闭除当前window之外的所有其他window
^+w s: 打开一个新窗口, 水平切分, 编辑相同的文件
^+w v: 打开一个新窗口,  垂直节分, 编辑相同的文件
^+w c: 关闭当前窗口

^+w j:  焦点移动至下方窗口
^+w k:  焦点移动至上方窗口
^+w h:  焦点移动至左方窗口
^+w l:  焦点移动至右方窗口
^+w w:  焦点移动至下方或右方窗口
^+w p:  焦点移动至上一个窗口
^+w r:  互换左右或上下窗口
^+w +:  增大当前窗口大小
^+w -:  减小当前窗口大小
^+w =:  自动调整大小


vim -o file1 file2 ...  水平分割, 用多个window打开
vim -O file1 file2 ...  垂直分割, 用多个window打开
```
## Buffer

```
buffer是一个被加载进内存的文件, 原始文件不会改变直到buffer被保存

buffer状态
    活动: 正在被展示, 对应于一个被打开的文件
    隐藏: 没有被展示, 对应于一个被打开的文件
    不活动: 没有被展示, 没有对应一个打开的文件(例如一个新的buffer)

:ls   查看缓冲区文件
:bn  下一帧 
:bp  上一帧 
:bd [number] delete [number] buffer, default current 
:bw close current buffer
:b [number]  go to [number] buffer
```

## TAb
```
一个tab可以包含多个window

:Te   tab explorer (used to open files)
:tabedit <file>  open file in new tab
gt  next tab
gT  previouse tab
[i]gt go to <number> tab
:tabs   show tab status
:tabclose [i]

vim -p file1 file2 ...   用tab模式打开文件
:bufdo tab split        将buffer切换成tab显示
```



## 使用
```
set nopaste
搜索介于start与end之间所有的内容, 可以跨行
    /start\_.*end/

<num>s
    删除num个字符之后插入

手动设置语法高亮
    :set syntax=<xml>

手动设置文件内容
    :set filetype=<html>

为某个文件类型单独进行配置
    .vimrc
        au FileType yaml setl noai sw=2 sts=2 et

可视模式
    多行按行首字母顺序排序 :sort 
    行尾添加;  :normal A;
    重复之前命令 :normal .

插入模式下
    粘贴文本  <C-r>0
    删除光标到行首的内容  <C-u> 
    删除光标到行尾的内容  <C-k> 
    删除字符 <C-h>
    删除单词 <C-w>

窗口绑定滚动
    <win1, wind2> :set scrollbind

对齐当前行
    zt  当前行设置为window首行
    zz  当前行设置为window居中
    zb  当前行设置为window尾行
```

## 代码对齐
```
:set filetype=xml
第一种
    =:10,40
第二种
    视图模式选中所有行 =  
```

## YCM pluggin
```
检查vim 版本最低7.4
yum -y install cmake python-devel
./install.py
```
## Upgrade vim
```
curl -L https://copr.fedorainfracloud.org/coprs/mcepl/vim8/repo/epel-7/mcepl-vim8-epel-7.repo -o /etc/yum.repos.d/mcepl-vim8-epel-7.repo
yum update vim*
```


## 默认编码
```
set encoding=utf-8
```

## 关闭yaml的自动缩进
```
autocmd FileType yaml let b:did_indent = 1
```

## 代码折叠
```
vimdiff会有自动代码折叠
    zo: open fold
    zc: close fold
    zr: reduce folding level
    zm: one more folding level
    zR: reduce completely the folding
    zM: fold most
```

## Centos8 安装NeoVIM
```
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
yum install -y neovim 


# 使用vim的配置
mkdir -p ~/.config/nvim

~/.config/nvim/init.vim
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath=&runtimepath
    source ~/.vimrc

alias vim="nvim"
alias vimdiff="nvim -d"


# use as git diff tool
git config --global merge.tool vimdiff
git config --global mergetool.vimdiff.path nvim
git config --global mergetool.trustExitCode true
git config --global core.editor nvim # 默认使用vim, 否则merge分支会报错
```

## 打开256color支持
```
检查当前
    tput colors
1. .bashrc
    如果存在 /usr/share/terminfo/x/xterm-256color
    export TERM=xterm-256color
2. .vimrc
    set t_Co=256
3. 检查是否应用256色
    :runtime syntax/colortest.vim 
```
