# Redis备份与恢复


## 备份

### 启用AOF备份

```bash
/usr/local/redis/bin/redis-cli -h 127.0.0.1 -p 6379  -a hzsun310012  --no-auth-warning  CONFIG SET appendonly yes
```


### 开始AOF备份

```bash
 /usr/local/redis/bin/redis-cli -h 127.0.0.1 -p 6379  -a hzsun310012  --no-auth-warning  BGREWRITEAOF
```

### 查看备份是否完成

```bash
/usr/local/redis/bin/redis-cli -h 127.0.0.1 -p 6379  -a hzsun310012  --no-auth-warning  info persistence
```

#### 关键字段解析

- aof_rewrite_in_progress：值为 0 表示当前无 AOF 重写（备份）进行36。
- aof_current_size 和 aof_base_size：若两者大小一致且稳定，说明最后一次 AOF 备份已完成

## 恢复


### 启用AOF持久化

```
appendonly yes

```

### 覆盖目标机器的 AOF 文件


### 修复并检查 AOF 文件有效性（可选）

```bash
/usr/local/redis/bin/redis-check-aof --fix appendonly.aof
```

### 启动redis

```bash
redis-server /usr/local/redis/redis.conf &
```


### 查看所有键是否存在

```bash
/usr/local/redis/bin/redis-cli -h 127.0.0.1 -p 6379  -a hzsun310012  --no-auth-warning  keys "*"
```
