# Redis常用命令

### 批量删除匹配的key

redis-cli -h localhost -p 6379 -a redis_password EVAL "local keys = redis.call('keys', ARGV[1]) if #keys > 0 then return redis.call('del', unpack(keys)) else return 0 end" 0 "your_pattern:*"

#### 基本逻辑

1. 使用redis.call('keys', ARGV[1])获取匹配模式的所有key。

2. 判断返回的keys数组的长度是否大于0，如果大于0，则表示有匹配的key存在。

3. 如果有匹配的key存在，则使用redis.call('del', unpack(keys))删除所有匹配的key。

4. 如果没有匹配的key存在，则返回0。
