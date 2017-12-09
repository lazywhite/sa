### stash  
```
stash: 保留本地所有变更， 从HEAD检出    
git stash [save <name>]  
git stash apply [default stash:{0}]   
```
  
### merge 
``` 
(master) git merge --no-ff (no fast-forward)  <branch>

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
git checkout --track origin/serverfix  
  
  
git request-pull  
git cherry-pick -x  
  
```   
### 打补丁  
```
第一种打补丁方式
git format-patch -M master ## generate a mailbox git-format patch   
git am  ## apply patch from mailbox  
  
第二种
<fix01>git diff master > 1.patch  
<master>git co -b fix01;git apply 1.patch;git co masster;git merge fix01  
  
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
```


## cherry-pick
```

git cherry-pick <commit-id>
    resolve merge conflict
    git add <file>

git cherry-pick --continue
    add commit message

    
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
git tag 'tag_name' <commit_id>  
git rev-parse 'tag_name' --> commit_id  


git tag -l (list)  
git tag -v 'name' (information)  
git checkout tags/v1.2 
```
  
## Checkout
```
git checkout -- <filename> (from stage)  
git checkout HEAD -- <filename> (from repo)  
git rm --cached <file> (remove  from index, but not work directory)  
git checkout HEAD -- file (restore from repo)  
git checkout -- file (restore from index)  
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
git filter-branch \
--index-filter 'git rm --cached --ignore-unmatch linux/bzImage' <start>..<stop|HEAD>
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

```
1. 分支的相对路径  HEAD~[n]   HEAD之前的第n此提交
