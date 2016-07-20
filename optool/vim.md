#Buffer
```
:ls   查看缓冲区文件
:bn  下一帧 
:bp  上一帧 
:bd [number] delete [number] buffer, default current 
:bw close current buffer
:b [number]  go to [number] buffer
```

#TAb
```
:Te   tab explorer (used to open files)
:tabedit <file>  open file in new tab
gt  next tab
gT  previouse tab
[i]gt go to <number> tab
:tabs   show tab status
:tabclose [i]

vim -p file1 file2 ...   open files in tab mode
:bufdo tab split        translate bufferes into tabs
```


## Ignore 
```
/start\_.*end/
```
