# nacos部署文档

## 离线安装


### 解压`nacos-server-1.4.6.tar.gz`安装包

```bash
tar zxvf nacos-server-1.4.6.tar.gz -C /usr/local
```

### 修改配置

```bash
cd /usr/local/nacos/bin
vi application.properties
```
#### 修改端口号

```bash
server.port=31500
```

#### 持久化

```bash
spring.datasource.platform=mysql

db.num=1

db.url.0=jdbc:mysql://172.16.4.79:6006/nacosdb?characterEncoding=utf8&connectTimeout=1000&socketTimeout=3000&autoReconnect=true&useUnicode=true&useSSL=false&serverTimezone=UTC
db.user=nacos
db.password=nacos
```

#### 关闭access日志

```
server.tomcat.accesslog.enabled=false
```

### 开启权限认证

```bash
nacos.core.auth.enabled=true


nacos.core.auth.server.identity.key=serverIdentity
nacos.core.auth.server.identity.value=security

# 关闭白名单
nacos.core.auth.enable.userAgentAuthWhite=false
```

### 启动服务

```bash
#Linux/Unix/Mac
#启动命令(standalone代表着单机模式运行，非集群模式):

sh startup.sh -m standalone
```

## 安装脚本

```bash
#/bin/bash

read -p "请输入maridb数据库IP地址：" IP  
echo "maridb数据库IP地址为: $IP"

read -p "请输入maridb数据库PORT：" PORT  
echo "maridb数据库PORT为: $PORT"

read -p "请输入nacos库用户名：" USERNAME  
echo "nacos库用户名为: $USERNAME"

read -p "请输入nacos库密码：" PASSWORD  
echo "nacos库密码为: $PASSWORD"



# 1.解压安装
if [ ! -f "nacos-server-1.4.6.tar.gz" ];then
	echo "未找到nacos-server-1.4.6.tar.gz文件"  
    exit 1  
fi

tar zxvf nacos-server-1.4.6.tar.gz

cd nacos/conf ||exit 1

# 2.修改配置文件
sed -i "s|server.port=8848|server.port=31500|g" application.properties
sed -i "s|# spring.datasource.platform=mysql|spring.datasource.platform=mysql|g" application.properties
sed -i "s|# db.num=1|db.num=1|g" application.properties
sed -i "s|# db.url.0=jdbc:mysql|db.url.0=jdbc:mysql|g" application.properties
sed -i "s|127.0.0.1:3306|$IP:$PORT|g" application.properties
sed -i "s|# db.user.0=nacos|db.user.0=$USERNAME|g" application.properties
sed -i "s|# db.password.0=nacos|db.password.0=$PASSWORD|g" application.properties
sed -i "s|nacos.core.auth.enabled=false|nacos.core.auth.enabled=true|g" application.properties
sed -i "s|nacos.core.auth.server.identity.key=|nacos.core.auth.server.identity.key=k12-nacos|g" application.properties
sed -i "s|nacos.core.auth.server.identity.value=|nacos.core.auth.server.identity.value=k12@310012|g" application.properties

# 3.启动nacos
cd .. ||exit 1

./bin/startup.sh -m standalone

# 4.开启防火墙端口
firewall-cmd --add-port=31500/tcp --permanent
firewall-cmd --reload
```

## 设置开机自启

```
vim /usr/lib/systemd/system/nacos.service

[Unit]  
Description=nacos  
After=network.target  

[Service]  
Type=forking  
ExecStart=/opt/nacos/bin/startup.sh -m standalone  
ExecReload=/opt/nacos/bin/shutdown.sh  
ExecStop=/opt/nacos/bin/shutdown.sh  
PrivateTmp=true  

[Install]  
WantedBy=multi-user.target
```
