## About
```
sed - stream editor for filtering and transforming text
```
## Keyword
pattern space: 执行命令的区域
address: 进行匹配的模式, 可规定上下限
hold space: 用来存储临时内容
命令打包: {} 

## Params
```
-n,--quiet,--silent: 不自动打印pattern space
=: 打印当前行号
s: 替换
a text:  在匹配行后面添加字符, 换行用\转义
i text:  在匹配行前面添加字符, 换行用\转义
r filename: 从文件读取内容, 添加到匹配行之后
c text: 替换行
d: 删除匹配行

```
## Example
```
sed 's/<[^>]*>//g' a.html 删除html里面所有的标签
sed '3s/my/your/g' mypets.txt  替换第三行所有my
sed '3,6s/my/your/g' mypets.txt  替换第三行到第六行所有my
sed '3,$s/my/your/g' mypets.txt  替换第三行到末尾所有my
sed 's/s/S/1' mypets.txt  替换所有行第一个s
sed 's/s/S/3' mypets.txt  替换所有行第三个s
sed 's/s/S/3g' mypets.txt  替换所有行第三个到最后一个s
sed '1,3s/my/your/g; 3,$s/This/That/g' my.txt 类似于两条命令加管道
sed 's/my/[&]/g' my.txt  &代表被匹配到的内容
sed 's/This is my \([^,]*\),.*is \(.*\)/\1:\2/g' my.txt 用括号表示标记
sed -n '/fish/p' my.txt  打印匹配行
sed 'N;s/\n/,/' pets.txt 将匹配行的下一行纳入匹配区
sed '3,6 {/This/{/fish/d}}' pets.txt 匹配到包含This的行之后, 再删除fish
sed '1,${/This/d;s/^ *//g}' pets.txt 从第一行到最后一行，如果匹配到This，则删除之；如果前面有空格，则去除空格
sed '/dog/,+3s/^/# /g' pets.txt 地址的上限和下限, 包含dog的行及之后的三行

ts=20190401
sed -i "s/today/$ts/" a.txt  # 用双引号可以传递变量
```
