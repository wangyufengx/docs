# Redis源码安装

## 环境准备

### 安装pcre
```
yum install -y pcre
```

### 安装pcre-devel
```
yum install -y pcre-devel
```

## 安装redis

### 解压安装包到redis目录
```
tar zxvf redis-x.x.x.tar.gz
```

### 编译安装
```
cd redis-x.x.x
make

# 使用PREFIX指定安装目录
make install PREFIX=/usr/local/redis

# 拷贝配置文件redis.conf到安装目录
```
### 配置redis
```redis.conf
requirepass

bind
```

### 添加软连接
```
ln -s /usr/local/redis/bin/redis-server /usr/bin/redis-server
```

### 启动
```
redis-server /usr/local/redis/redis.conf
```

### 将服务注册为linux系统服务
```
[Unit]
Description=Redis persistent key-value database
After=network.target
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/usr/bin/redis-server /usr/local/redis/redis.conf --daemonize no --supervised systemd
Type=notify
User=redis
Group=redis
RuntimeDirectory=redis
RuntimeDirectoryMode=0755

[Install]
WantedBy=multi-user.target
```

### 重新加载 systemd 配置
```
sudo systemctl daemon-reload
```

### 启动 redis 服务
```
systemctl start redis
```

### 设置开机自启动
```
systemctl enable redis
```

