svnadmin
    create <target>
    dump: dump the repo to standard output

svn log --limit 10
svn copy http://host/trunk http://host/branches/branch_one
svn copy http://host/trunk http://host/tags/v1.0.01
<trunk> svn merge http://host/branches/branch_one
svn mergeinfo
svn info file_path

svn revert -R .
svn diff -r 64222:64212 trunk/apps/admin/views/tool.py
svn remove branches/jia_dev;svn ci

