## Parameters
```
-P: never follow symbolic links, this is the default behaviour
-L: follow symbolic links
-H: do not follow symbolic links
-D: debug   
```

## Options
```
-d: a synonym for -depth
-daystart: 
-depth:
-maxdepth:
-mindepth:
-mount:
-noleaf:
```
## Tests
```
+n: for greater than n,
-n: for  less than n,
n: for exactly n
-amin n: file was last accessd n minutes ago
-anewer file: file was last accessed more recently than file was modified 
-atime n: file was last accessed n*24 hours ago
-cmin n: file's status was last changed n minutes ago
-cnewer file: file's status was last changed more recently than file was modified 
-ctime n: file's status was last changed n*24 hours ago
-empty: file is empty and is either a regular file or a directory
-executable: matches files which are executable and directories which are searchable 
-false: always false
-fstype type: file is on a filesystem of type
-gid n: file's numeric group ID is n
-group name: file belongs to group gname
-ilname pattern: like *-lname* ,but the match is case insensitive, IF the -L option or the -follow option is in effect
-iname pattern: Like -name ,but the match is case insensitive,
-inum n: file has inode number n 
-iregex pattern: like -regex but the match is case insensitive
-links n: File has n links.
-lname pattern: file is a symbolic link whose contents match shell pattern "pattern"
-mmin n: file's data was last modified n minutes ago.
-mtime n: file's data was last modified n*24 hours ago.
-name pattern: base of file name
-newer file: file was modified more recently than file
-nogroup: no group corresponds to file's numeric group ID
-nouser: no user corresponds to file's numeric user ID
-path pattern: file name matches shell pattern pattern
-perm mode: file's permisson bits are exactly mode
-perm -mode: 
-perm /mode: 
-perm +mode:
-readable: matches files which are readable
-regex pattern: file name matches regulare expression pattern
-samefile name: file name matches regulare expression pattern
-size n[cwbkMG]
-true always true,
-type c: file is type of c
	b: block
	c: character
	d: directory
	p: named pipe
	f: regular file
	l: symbolic link
	s: socket
	D: door
-uid n: file's numeric user ID is n,
-used n: file was last accessed n days after its status was last changed
-user uname: file is owned by user 'uname'
-writeable: matches files which are writable
```
## Actions
```
-delete: delete files; true if removal successded
-exec command ; :
-exec command {} + 
-execdir command ;
-execdir command {} +
-fls file: like *-ls* but write to file like *-fprint*
-fprint file:
-fprint0 file
-ls: list current file in *ls -dils* format on standard output
-ok command ;like -exec but ask the user first 
-print: print the full file name on the standard output, followed by a newline
-print0 print the full file name on the standard output, followed by a null character that -print uses
-printf format:
```
  
## Examples
```
find /tmp -name core -type f -print|xargs /bin/rm -f
find /tmp -name core -type f -print0|xargs -0 /bin/rm -f
find . -type f -exec file '{}' \;
find $HOME -mtime 0
find /sbin /usr/sbin -executable \! -readable -print
find . -perm 644

find . -type f -size +4096c  # larger than size 
find . -type f -size -4096k # smaller than size 

find . -name "*.py" -or -name "*.sh"

find . -path ./migrations -prune -o -name "*.py" # 排除某些文件夹

find . -mtime +10 # 当前日期10天以前的
find . -mtime -10 # 当前日期10天以内的
```
