# mysql表操作

**ALTER TABLE运行时会对原表进行临时复制，在副本上进行更改，然后删除原表，再对新表进行重命名。
在执行ALTER TABLE时，其它用户可以阅读原表，但是对表的更新和修改的操作将被延迟，直到新表生成为止。
新表生成后，这些更新和修改信息会自动转移到新表上。(RENAME除外)**

### 修改表名

- 方式一：ALTER TABLE `旧表名` RENAME TO `新表名`;
- 方式二：RENAME TABLE `旧表名` TO `新表名`；

### 增加列字段

ALTER TABLE `表名` ADD COLUMN`列名`  列类型；

### 修改列字段

- 修改字段名时需要给定旧的和新的列名和列的当前类型。

ALTER TABLE `表名` CHANGE `旧列名` `新列名` 列类型；


### 删除列字段

#### 删除单列

ALTER TABLE `表名` DROP COLUMN `字段名`；

#### 删除多列

ALTER TABLE `表名` DROP COLUMN `字段名1`, DROP COLUMN `字段名2`；


### 修改列类型

ALTER TABLE `表名` MODIFY `列名` 列类型；

### 列位置

- 默认把列添加到最后。

- FIRST把列添加到第一行。

  示例：ALTER TABLE test ADD COLUMN name VARCHAR(64) FIRST;

- AFTER把列添加到某列后。

​		示例：ALTER TABLE test ADD COLUMN name VARCHAR(64) AFTER id;

## 锁

### 表加读写锁

LOCK TABLE `表名` READ|WRITE;

### 全局锁

FLUSH TABLE WITH READ|WRITE LOCK;

### 查看锁

SHOW OPEN TABLES	WHERE IN_use > 0;
SHOW STATUS LIKE '%lock%';

