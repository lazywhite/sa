## make server side svn repo
```
svnadmin create svn-test

# cd svn-test
conf/passwd
    [users]
    harry = harryssecret
    sally = sallyssecret

conf/svnserve.conf
    anon-access = none
    password-db = passwd
  

svnserve -d --listen-host 0.0.0.0 --listen-port 2345 -r /root
```

## make file architecture
```
svn co --username=test --password=test svn://localhost:2345/svn_test   local_svn
cd local_svn   
mkdir {trunk,branches,tags}
cd trunk
echo 'test msg' > file_a
svn add file_a
svn ci -m 'initial commit'
``` 

## make new branch and  push commit
```
svn copy <url_to_trunk> <url_to_new_br>
cd project/branches/white
echo 'new msg' >> file_a
svn ci -m 'update file_a'
```


## merge branch
```
cd project/trunk
svn update
svn merge --reintegrate <url_to_branch>  # fix merge-conflict
svn ci -m 'merge branch <br_name>'
svn rm <url_to_branch(old)> -m 'delete old branch'
svn copy trunk <url_to_branch(new)>

```  

## using git with svn
```
git svn clone svn://ip:port/svn-test -T trunk -b branches -t tags local_git_svn
# or 
git svn clone file:///tmp/test-svn -s  (standard layout)

cd local_git_svn

# show branches of remote svn repo
git br -a

# create branch
git svn branch -m 'create new branch' new

# fetch update from svn repo
(master)git svn fetch; git svn rebase

# if branch white updated
git co  white
git svn fetch; git svn rebase

# commit 
<branch> git svn dcommit

$ git svn branch -m "Topic branch" my_topic            # Create SVN branch called "my_topic"
## use svn copy instead cause authentication can't get password bug
$ git checkout  -b my-topic  # track upstream automaticlly
$ git svn dcommit --dry-run    # Make sure you're committing to the right SVN branch
$ git svn dcommit              # Commit changes to "my_topic" branch in SVN

## delete a remote branch
svn rm svn://dev.in/branches/ios_20130709150855_39721/
git branch -d -r ios_20130709150855_39721
```


## Tips
```
git svn show-ignore > .git/info/exclude  ## no .gitignore file
git svn create-ignore
git svn blame <file>
git svn info
```

