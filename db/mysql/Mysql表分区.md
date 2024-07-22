# MySQL分区


## 列表分区

### 创建表分区

```
CREATE TABLE `table_name`(
  `field_name` `file_type`
  ...
)
PARTITION BY LIST (`field_name`) (
    PARTITION partition_name VALUES IN (field_value...)
);
```


### 添加表分区定义

```
ALTER TABLE `table_name`
PARTITION BY LIST (`field_name`)
(PARTITION partition_name VALUES IN (field_name_value...))
```

### 添加表分区

```
ALTER TABLE `table_name`
ADD PARTITION (PARTITION partition_name VALUES IN ('partition_param'));
```

### 删除某个分区

```
ALTER TABLE `table_name`
DROP PARTITION partition_name
```

### 删除整个表分区

```
ALTER TABLE `table_name` REMOVE PARTITIONING;
```

## 查询表分区

```
SELECT  PARTITION_NAME  
FROM    information_schema.PARTITIONS  
WHERE   TABLE_SCHEMA = `database_name`  
AND TABLE_NAME = `table_name`;
```
