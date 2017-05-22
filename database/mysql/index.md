mysql的索引结构是B+Tree, 包含两种类型
    聚簇索引: 逻辑顺序与数据物理位置一致, 类似字典拼音目录, 适合多行查询
    非聚簇索引: 逻辑顺序不与物理位置一致, 类似字典偏旁目录，适合单行查询

索引列必须有值， 唯一索引必须有不重复的值

```
## 索引
```
drop index `PRIMARY` on user_info; #删除主索引
alter table <testTable> drop index <idx_age>; 

create unique index idx_id [using btree|hash] on user_info(id); #创建索引

show index from <table name>
create index idx_id on table(col1, col2) ## 多列索引
```
