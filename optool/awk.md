## Parameters
```
-F field-separator 
-v var=val assign var=val
-f program-file read the AWK program source from the file 
```

## Key word
```
Records: Normally, records are separated by newline characters, You
can control how records are separated by asigning values to the built-in
variabe *RS*.
Fileds: As each record is read, gawk splites the record into fields, using 
the value of *FS* variable
```
## Built-in variables
```
ARGC: the number of command line arguments 
ARGIND: the index in ARGV of the current file being processed
ARGV: array of command line arguments
CONVFMT: the conversion format for numbers, "%.6g", by default
ENVIRON: an array containing the values of the current environment,ENVIRON["HOME"]
FILENAME: the name of current input file,*undefined inside the begin block*
FNR: the input record number in the current input file
FS: the input field separator, a space by default
NF: the number of fileds in the current input record
NR: the total number of input records seen so far
OFMT: the output format for numbers, "%.6g", by default
OFS: the output field separator, a space by default
ORS: output record separator, a newline by default
PROCINFO: an array about information of the running awk program PROCINFO["pid"]
RS: the input record separator , by default a newline
```
## Usage example
```
awk -F: '{printf("%-10s %-10s \n",$1,$2)}' /etc/passwd
awk -F: 'BEGIN{OFS="\v"}/root/{print $7}' /etc/passwd


awk -F, 'NR==2{printf "%0.2f", $8/$9}' file.csv
```
## split
```
time="12:34:56"
out=`echo $time | awk '{split($0,a,":");print a[1],a[2],a[3]}'`
echo $out
```
## substr
```
substr(s,p) 返回字符串s中从p开始的后缀部分
substr(s,p,n) 返回字符串s中从p开始长度为n的后缀部分
echo "123" | awk '{print substr($0,1,1)}'
```
## length
```
echo "123" | awk '{print length}'
echo "abc 1234"|awk '{print length($1)}'
```
## variable
```
timeout=5
awk -v timeout=timeout  '{if ($1 > timeout) print}' ## 正确
awk '{if ($1 > $timeout) print}' ## 错误, 无法进行变量替换
```
