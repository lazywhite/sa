## 提交前注意事项  
>   用rebase保持提交的质量, 写清楚comment  
>    千万不要rebase一个已经推送过的commit    
  
## Workflow  
1. centralized workflow  
2. integration-manager workflow  
3. Diactor and  Lieutenants Workflow  
  
## Commands  
### repack  
git repack -a -d (直接删除)    
git repack -A -d (不直接删除)    
  
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
