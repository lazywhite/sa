## 提交前注意事项  
>   用rebase保持提交的质量, 写清楚comment  
>   千万不要rebase一个已经推送过的commit    
>   flask8 代码检查
## Rewrite commit histroy
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
    
## Workflow  
1. centralized workflow  
2. integration-manager workflow  
3. Diactor and  Lieutenants Workflow  
  
## Commands  
### repack  
git repack -a -d (直接删除)    
git repack -A -d (不直接删除)    
  
### commit
git commit -a -F -  (input from stdin)

### config  
git config push.default=simple  
  
### stash  
stash: store all information of work dir  and stage, checkout from HEAD  
git stash [save <name>]  
git stash apply [default stash:{0}]   
  
  
### merge  
git merge --no-ff (no fast-forward)  
git pull --no-ff (no fast-forward)  
  
  
### blame  
git blame: Show what revision and author last modified each line of a file  
git show :Show various types of objects  
git revert:Undo commit but All commits have been pushed   
git blame -L 12,22 sample.rb  
  
### submodule  
git submodule add url  
  
  
### bisect  
git bisect start  
git bisect good  
git bisect bad  
git bisect visualize  
  
  
### cat-file   
git cat-file -t 532c : commit  
git cat-file commit 532c : tree, author, committer  
git ls-tree tree-hash  
git cat-file -t blob-hash : blob  
git cat-file blob  blob-hash  
  
  
### tag  
git tag 'name'   
git tag -l (list)  
git tag -v 'name' (information)  
  
### rebase  
git rebase -i  
git rebase <upstream> <branch>  
git rebase --onto master next topic  
  
### push  
git push origin --tags  
git push origin v1.5  
git push origin local_branch:remote_branch  
git push origin :serverfix   删除远程分支  
git checkout --track origin/serverfix  
  
  
git request-pull  
git cherry-pick -x  
  
  
### log  
git log master..featureA  
git log master...featureA  
git log origin/master..HEAD  : what will be pushed to remote  
  
git filter-branch --tree-filter 'rm -f password.txt' HEAD : only on current br  
[--all on all branches]  
git filter-branch --tree-filter "find * -type f -name '*~' -delete" HEAD  
  
  
  
### patch  
git format-patch -M master ## generate a mailbox git-format patch   
git am  ## apply patch from mailbox  
  
<fix01>git diff master > 1.patch  
<master>git co -b fix01;git apply 1.patch;git co masster;git merge fix01  
  
### revert  
git revert ## like patch -R  


### Tips
#### The seven rules of a great git commit message
```
Separate subject from body with a blank line
Limit the subject line to 50 characters
Capitalize the subject line
Do not end the subject line with a period
Use the imperative mood in the subject line
Wrap the body at 72 characters
Use the body to explain what and why vs. how
```

#### Create branch from a commit
git co -b 'new' <commit-id>

### List repo contributors
git log --format='%aN' | sort -u


### Problem
```
$ git push origin master
Counting objects: 1, done.
Writing objects: 100% (1/1), 215 bytes | 0 bytes/s, done.
Total 1 (delta 0), reused 0 (delta 0)
remote: GitLab: API is not accessible
To http://gitlab.test.com/white/maven_test.git
 ! [remote rejected] master -> master (pre-receive hook declined)
error: failed to push some refs to 'http://gitlab.test.com/white/maven_test.git'
```
wait some time



### push all 
git push --all origin
git push --tags origin


### get all
git fetch --all --tags origin



## set branch upstream
git branch --set-upstream <local_br> <upstream>/<branch>



## git colorful log output
git log -n 5 --pretty=format:"%C(yellow)%h%Creset %Cred%an%Creset %Cgreen%ad%Creset" --date=iso

## case insensitive
[case problem](http://www.worldhello.net/gotgit/08-git-misc/030-case-insensitive.html)

### Topic
```
1. undo 'git add': git reset HEAD <file>
    keep change of files in work directory and remove it from stage area

2. check what commits will be commited
git log --branches --not --remotes
```


## cherry-pick

git cherry-pick <commit-id>
    resolve merge conflict
    git add <file>

git cherry-pick --continue
    add commit message
