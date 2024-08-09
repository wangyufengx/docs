# nacos部署文档

## 离线安装


### 解压`nacos-server-1.4.1.tar.gz`安装包

```bash
tar zxvf nacos-server-1.4.1.tar.gz -C /usr/local
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
