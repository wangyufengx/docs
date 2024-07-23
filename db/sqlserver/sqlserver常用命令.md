# SQL Server常用命令

## 建库指定排序规则

SQL Server 使用的是代码页（Code Pages）和排序规则（Collation）来处理字符编码和排序问题

```
CREATE DATABASE `database_name`
COLLATE Chinese_PRC_CI_AS;
```

[排序规则和 Unicode 支持](https://learn.microsoft.com/zh-cn/sql/relational-databases/collations/collation-and-unicode-support?view=sql-server-ver16)
