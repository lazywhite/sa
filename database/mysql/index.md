## 类别
B+Tree
    聚簇索引: 逻辑顺序与数据物理位置一致, 类似字典拼音目录, 适合多行查询
    非聚簇索引: 逻辑顺序不与物理位置一致, 类似字典偏旁目录，适合单行查询

Fractal Tree (tokudb) 分型树索引

## tree
1. 二叉树
2. 自平衡二叉树 如：红黑树
3. B树
4. 堆
5. trie: 后缀树， 三叉查找树
6. 二叉空间分割树
7. 非二叉树
8. 空间数据分割树： R树
9. 其他树： 散列树

## command
```
show index from <table name>
create index idx on  table(col1, col2) ## 多列索引

```
