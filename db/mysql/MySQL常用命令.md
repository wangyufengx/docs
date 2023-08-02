# MySQL常用命令

## 用户

### 创建用户

- 方法一:明文指定密码

CREATE USER '用户'@'访问权限' IDENTIFIED BY '密码';

- 方法二:密文指定

获取密码的哈希值

SELECT PASSWORD('密码');

通过哈希值设置密码

CREATE USER 'hello'@'%' IDENTIFIED BY PASSWORD '密码的哈希值';

### 修改用户密码

- 方法一

set password for '用户'@'%' = password('密码');

- 方法二

mysqladmin -u 用户名 -p 旧密码 password 新密码


## 访问权限


### 查看访问权限

SELECT user,host FROM mysql.user WHERE user = '用户';

### 修改远程访问权限

GRANT ALL PRIVILEGES ON *.* TO '用户'@'%' IDENTIFIED BY '密码' WITH GRANT OPTION;

FLUSH PRIVILEGES;


## 备份

### 导出数据

mysqldump -u root -p  --all-databases > 导出文件名称.sql

--all-databases 所有数据库，包含系统库
--database 指定数据库
--ignore-table=db_name.tbl_name 不要转储给定的表，该表必须使用数据库名和表名指定。要忽略多个表，请多次使用此选项。此选项也可用于忽略视图。
--tables 覆盖--databases or-B选项。指定表
--skip-triggers 跳过触发器


### 导入脚本
mysql -u root -p < 导入的数据库脚本.sql


## mysql表操作

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

