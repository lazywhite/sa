# Grep Usage
```
grep,egrep,fgrep - print lines matching a pattern	
		-i ignore-case
		-v invert-match
		-f obtain patterns from FILE, one per line
		-w select only those lines containing matches that form whole words
		-x select only those matches that exactly match the whole line
		-c count	
		--color=auto	
		-L files-without-match 	
		-l files-with-match	
		-m max-count=Num 	
		-o print only the matched parts of matching line
		-q quiet, do not write anything to standard output
		-s suppress error message about nonexistent or unreadable files
		-H with-filename,default
		-h --no-filename suppress the prefixing of file names on output
		-n prefix eacho line with line-number
		-Z output a zero byte instead of the character that normally follows a file name
		-A print Num lines of trailing context *after* matching lines
		-B print Num lines of leading context *before* matching lines
		-C print Num lines of output context 
		--exclude=GLOB  skip files whose base name matches GLOB
		--exclude-from=FILE skip files whose name matches any of the file-name globs read from FILE
		--exclude-dir=DIR exclude directories matching the pattern DIR from recursive searches
		--include=GLOB search only files whose base name matches GLOB
		-r read all files under each directory
```
  
# grep regular expression  
```
[]
[^]
^
$
\< \> \b \B \W \w
? * + {n} {n,} {,m} {n,m}

-H with-fileName  # 搜索多个文件时需要
-n with-line-number # 带行号


grep -nHro '"resource_id":"[^"]*"' /root/lucci|grep -v 'CPC'

```
