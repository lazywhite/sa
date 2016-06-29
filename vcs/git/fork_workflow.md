1. white create main repo
    origin    git@gitlab.test.com:white/maven_test.git
2. test fork main repo
    origin    git@gitlab.test.com:test/maven_test.git
3. test add main repo as upstream
    upstream    git@gitlab.test.com:white/maven_test.git (fetch)
    upstream    git@gitlab.test.com:white/maven_test.git (push)
4. test sync upstream
    git co master; git pull upstream master
5. test create new feature branch
    git co -b feature01
6. test add commit
7. test rebase commit   
    git rebase -i
8. test sync upstream
    git rebase master feature01 # make sure main repo could be fast-forwarded
9. test merge feature01 into local master
10. test create merge request : test:feature01 --> upstream:master
11. white get notified by this merge request(by email or dashboard)
12. white fetch test:feature01 
```
    # method 01
    [remote "origin"]
    url = http://gitlab.test.com/white/maven_test.git
    fetch = +refs/heads/*:refs/remotes/origin/*
    fetch = +refs/merge-requests/*/head:refs/remotes/origin/merge-requests/*    

    git fetch origin
```
```
    # method 02
    git fetch http://gitlab.test.com/test/maven_test.git feature01
    git checkout -b test/maven_test-feature01 FETCH_HEAD
    # make sure everything is ok
    git co master; git merge --no-ff feature01 
    git push origin master
```
```
    # method 03
    view code diff
    merge on dashboard
```

13. test can sync upstream 
