### 
```
working tree
stage area/index
repository(.git)


file state
    tracked/untracked
    modified/unmodified
    staged/unstaged
    commited
```

### stash
```
stash: 保留本地所有变更， 从HEAD检出
git stash [save <name>]
git stash apply [default stash:{0}]
git stash drop [default stash:{0}]
```

### merge
```
(master) git merge --no-ff (no fast-forward)  <branch>

```

## config
```
git config -l   列出所有配置项
```


### submodule
```
git submodule add url
git submodule update --init
```

### bisect
```
git bisect start
git bisect good
git bisect bad
git bisect visualize
```

### cat-file
```
git cat-file -t 532c : commit
git cat-file commit 532c : tree, author, committer
git ls-tree tree-hash
git cat-file -t blob-hash : blob
git cat-file blob  blob-hash
```


### rebase
```
分支衍合
	git rebase [upstream] <branch>
	git rebase --onto master next topic

更改历史提交
	git rebase -i HEAD~3
	git rebase -i <commit-id>
	git rebase --continue

默认不允许修改root commit
    git rebase -i --root
```

### push
```
git push origin --tags
git push origin v1.5
git push origin local_branch:remote_branch
git push origin :serverfix   删除远程分支


git request-pull
git cherry-pick -x

```

## clone
```
git clone <> [local dir]
    -b <>: clone某个branch而不是master
```

### 打补丁
```
第一种
    git format-patch 

第二种
    <feature1-hotfix>git diff feature1 > 1.patch

    <master>git apply --check 1.patch #检查是否有冲突
    <master>git apply --reject 1.patch #默认情况下有冲突，git apply会失败，带上--reject后，自动更改无冲突的文件，有冲突的生成*.rej

```


### diff
```
git diff 调用git内置的diff tool来显示差异
git difftool 调用外置diff工具
    git difftool --tool-help
    git difftool --tool=<>
    使用vimdiff时, 退出diff命令执行, :qa后Ctrl+C

git diff <cid01> <cid02> -- file
git diff --cached (diff between index and HEAD)
git diff (diff between work tree and index )
git diff HEAD (diff between work tree and HEAD)
git diff <branch> (diff between current work tree and branch HEAD)


git diff <src-commit> <dest-commit> 比较两次提交之间的差异

git diff = git diff HEAD   # 比较当前工作目录代码与最近一次提交的差别


git diff --name-only <hash1> <hash2>
git diff --name-only <other-br>   # 仅显示不同的文件
```


## cherry-pick
```
git cherry-pick <commit-id>
    resolve merge conflict
    git add <file>

git cherry-pick --continue
    add commit message

```

## mergetool
```
git config --global merge.tool p4merge
git config --global mergetool.p4merge.path "/Applications/p4merge.app/Contents/MacOS/p4merge"
git config --global mergetool.p4merge.trustExitCode false
git config --global mergetool.keepBackup false


git merge <other-br>  # got conflict
git mergetool <file1>

如果中途退出, 需要git co -m <file1>, 重新执行git mergetool <file1>
```

## reset
```

git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]

    --soft      不操作index和working tree， 仅将HEAD置为commit
    --hard      重置index和working tree
    --mixed     重置index，不重置working tree

```


## Tag
```
git tag  # 列出所有tag
git tag -l "1.8*" $ 列出符合条件的tag

标签类型
	轻量标签
		git tag <v1.4>
		git show v1.4 # 仅显示提交信息
	附注标签
		git tag -a <v1.4> -m "<comment>"
		git show v1.4 # 显示打标签者，日期，备注及提交信息

后期打标签
	git log --pretty=oneline
	git tag -a v1.2 913c1b21

共享标签
	git push origin <v1.2>
	git push --tags # 推送所有

删除标签
	git tag -d v1.2  #本地删除
	git push origin --delete <v1.2> # 删除远程

检出
	git co v1.4  # detached HEAD
	git co -b local_v1.4 # 新建分支， 可做变更
```

## Checkout
```
--track/-t 

git checkout --track origin/serverfix
git checkout -- <filename> (from stage)
git checkout HEAD -- <filename> (from repo)
git rm --cached <file> (remove  from stage, but not work directory)

git checkout -b dev -t origin/dev  创建一个跟踪远程分支的本地分支
git checkout -b local-v1 v1 从v1检出一个local-v1分支并checkout
```


## 如何提高commit质量
```
关于commit message
1. 提交的标题和内容之间添加空行
2. 标题内容不要超过50个字符
3. 标题单词首字母大写
4. 不需要用句号结束标题
5. 标题内容应该为祈使句
6. 内容宽度不要超过72个字符
7. 内容解释做了什么， 为什么要做， 而不是为什么要做



用rebase保持提交的质量, 写清楚comment
千万不要rebase一个已经推送过的commit
```


## 问题

```
$ git push origin master
Counting objects: 1, done.
Writing objects: 100% (1/1), 215 bytes | 0 bytes/s, done.
Total 1 (delta 0), reused 0 (delta 0)
remote: GitLab: API is not accessible
To http://gitlab.test.com/white/maven_test.git
 ! [remote rejected] master -> master (pre-receive hook declined)
error: failed to push some refs to 'http://gitlab.test.com/white/maven_test.git'

gitlab繁忙，间隔一段时间重新push

-----------------
Win/Mac下文件名不区分大小写问题
$ git mv changelog ChangeLog
fatal: destination exists, source=changelog, destination=ChangeLog


$ git mv changelog non-exist-filename
$ git mv non-exist-filename ChangeLog
$ git commit
```


### Rewrite commit histroy
```

git filter-branch --commit-filter '
        if [ "$GIT_AUTHOR_EMAIL" = "rock@domain.com" ];
        then
                GIT_AUTHOR_NAME="white";
                GIT_AUTHOR_EMAIL="346816483@qq.com";
                git commit-tree "$@";
        else
                git commit-tree "$@";
        fi' HEAD

git push -f origin master
```
### Remove files from all commits
```
需要在repo根目录运行
git filter-branch \
--index-filter 'git rm --cached --ignore-unmatch linux/bzImage' -f
```

### Remove directory from all commits
```
git filter-branch --tree-filter 'rm -rf project' --prune-empty HEAD
git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
git gc

```



## 常用命令
```
git grep -I -i todo
git reflog
git revert <commit-ish>   # 给某次提交打反提交

git co -b 'new' <commit-id>        从特定提交检出分支
git log --format='%aN' | sort -u   列出commit提交者
git log --branches --not --remotes  查看哪些提交将会被push

git show   显示blobs, trees, tags, commits信息
git blame -L 12,22 sample.rb   按行显示文件的修改记录

git branch --set-upstream <local_br> <upstream>/<branch> 为分支设置上游

git fetch --all --tags origin  从remote获取所有更新
git push --all --tags origin    将本地所有更改push到remote

git log -n 5 --pretty=format:"%C(yellow)%h%Creset %Cred%an%Creset %Cgreen%ad%Creset" --date=iso  log彩色输出


git revert ## like git patch -R


git repack -a -d (直接删除)
git repack -A -d (不直接删除)

git commit -a -F -  从标准输入读取提交信息

git fetch origin [remote_br]:[local_br] 拉取远程分支到本地

本地git br -a, 发现有remotes/origin/<some_br>, 但origin其实已经没有了, 需要更新远程分支列表
    git remote update origin --prune

新建分支前, 先更新基础分支
    git pull origin/<br>
```

## Problem
```
git clone Peer reports incompatible or unsupported protocol version.
    yum -y update nss curl libcurl

fatal: object 47e1979a125aa4bac0d03f8d31814036404a1196 is corrupted
    rm -f .git/object/47/e1979a125aa4bac0d03f8d31814036404a1196 ; git pull
```


## Ignore
```
1. .gitignore
2. .git/info/exclude  //不会纳入版本管理
```

## FileMode
```
不将文件权限纳入版本管理
.git/config
  [core]
  fileMode = false
```


## 修改author信息
```
git push发现author 邮箱格式不正确

git config user.name  <>
git config user.email  <>
git commit --amend --reset-author --no-edit
或者
git commit --amend --author="userName <userEmail>", 注意<>为必须
```

## 设置本地分支track远程分支
```
git branch -u upstream/foo foo
或者
git branch --set-upstream-to=upstream/foo foo
```
## 重命名某分支
```
If you want to rename a branch while pointed to any branch
    git branch -m <oldname> <newname>

If you want to rename the current branch, you can do
    git branch -m <newname>
```

## 根据某个分支新建分支
```
git br <new branch> <base branch>
git br dev origin/master
```


## 在virtualbox share folder模式下, git status状态错误

```
将缓存刷入磁盘
echo 3 > /proc/sys/vm/drop_caches

git config core.fileMode false
git config core.ignorecase false
```

## 打印config出处

```
git config --list --show-origin
```

## 谨慎使用rebase
```
假设你使用latest分支开发, 并且push到了origin
master分支有提交, 如果rebase master, 会导致本地分支的commit发生改变，从而跟origin/latest分支diverged
此时如果latest分支只有自己使用， 可以直接git push -f
如果latest分支有别的人也在用， 此时不能使用rebase， 需要用merge, 产生一个新的提交， 然后push origin/latest
merge时可能会有conflict，解决后提交， master 此时merge latest会快进
每次latest merge完master，push后, 如果latest分支引入了新的feature, master可以选择不merge latest, 否则应及时merge latest

如果master没有及时merge latest， latest后续merge master，还要重新处理同样的conflict
```

## note
```
working directory-->staging directory(index)-->repository
git stash会将文件存储在.git/refs/stash

.git/HEAD指向当前分支
.git/index文件保存暂存区信息

git merge出现冲突，想要abort，直接git reset --hard HEAD

```

# git底层工作原理

```
git是一个键值对数据库，可以向git中插入任意内容，会返回一个唯一键，可以通过键在任意时间取回对应内容

git内部对象类型
    blob  (对应文件)
    tree (对应目录)
        每一行表示一个object, 格式为mode type sha1 filename
    commit
        tree sha1
        parent commit(若有)
        parent commit(若有)
        author
        commit
        空行
        注释
header
    类型+空格+字节数+空字节
content

header+content的sha1值(40个字符)为文件名, 存储在.git/objects/<前两个字符>/<后38个字符>
header+content的zip压缩值为内容, 存储在上一步的文件中

git update-index 将文件加入暂存区
git write-tree 将暂存区的文件创建成tree object并提交
git commit-tree <tree sha1> 创建一个commit对象

git cat-file  <sha1>
    -p pretty print (content)
    -t show type
    -s show size
git hash-object <path>
    -w write to object database, otherwise return sha1 only
    --stdin read object from stdin
```

## PS1显示git branch
```
parse_git_branch() {
         git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
```
## 查看某行代码的作者的email地址
```
git blame <file>
    08422f04 (bob.zc        2019-09-14 17:44:30 +0800   5) Features:

git log --format="%ae" 08422f04 第一行就是
```

## cherry-pick
```
git cherry-pick <commit>
git cherry-pick <commitA>^..<commitB> # 包含A,B之间所有commit
git cherry-pick <commitA>..<commitB> # 不包含A, 到B之间所有commit
```

## 切换分支失败
```
root@control-plane product--init (live_jsx) # git co live
error: The following untracked working tree files would be overwritten by checkout:
    networkpolicy/templates/Deployment.yaml
    Please move or remove them before you switch branches.
    Aborting

是共享文件系统的问题, 将代码目录移动到linux文件系统即可
```

## using ssh rather than https
```
git config --global url."git@github.com:".insteadOf https://github.com/
git config --global url."git://".insteadOf https://
```

## git gc unable to unlink, Operation not permitted
```
共享文件夹问题, chmod 777 -R /repo, 或者移动至linux文件系统即可
```

