# influxdb 安装文档

### 解压安装包

```bash
cd /opt
# 解压
tar zxvf influxdb-1.8.10_linux_amd64.tar.gz
```

### 移动文件夹

```
cp -r /opt/influxdb-1.8.10-1/etc/* /etc/
cp -r /opt/influxdb-1.8.10-1/usr/* /usr/
cp -r /opt/influxdb-1.8.10-1/var/* /var/
```

### 将服务注册为linux系统服务

```
vim /usr/lib/systemd/system/influxdb.service

[Unit]
Description=influxdb
[Service]
ExecStart=/usr/bin/influxd
# 指定二进制程序目录及执行时需要加载的配置文件目录
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
```

### 启动服务

```bash
systemctl start influxdb.service
```

### 创建用户

```bash
localhost:~ # influx
Connected to http://localhost:8086 version 1.8.10
InfluxDB shell version: 1.8.10
> show users
user admin
---- -----
> create user "root" with password 'xxxxxxx' with  all privilege
> exit
```

### 修改密码

```bash
localhost:~ # influx
Connected to http://localhost:8086 version 1.8.10
InfluxDB shell version: 1.8.10
> show users
user admin
---- -----
root true
> set password for root = 'xxxxxxx'
> exit

```

### 开启权限认证


```bash
vim /etc/influxdb/influxdb.conf


[http]
	auth-enabled = true
```



### 重启服务

```bash
systemctl restart influxdb.service
```


### 注意事项

1. 开启权限后执行`show users`可能出现一下问题,但是不影响用户创建。
```
> show users
ERR: unable to parse authentication credentials
Warning: It is possible this error is due to not setting a database.
Please set a database with the command "use <database>".
```



