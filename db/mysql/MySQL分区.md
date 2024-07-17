# MySQL分区

## 创建表分区




## 添加表分区

```
ALTER TABLE `table_name`
ADD PARTITION (PARTITION partition_name VALUES IN ('partition_param'))
```


## 查询表分区

```
SELECT  PARTITION_NAME  
FROM    information_schema.PARTITIONS  
WHERE   TABLE_SCHEMA = `database_name`  
AND TABLE_NAME = `table_name`;
```
