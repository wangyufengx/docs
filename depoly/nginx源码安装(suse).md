# nginx 源码安装(suse)


## 环境准备

### 安装gcc
```bash
zypper install -y gcc
```

### 安装make
```bash
zypper install -y make
```

### 安装pcre
```bash
zypper install -y pcre
```

### 安装pcre-devel
```bash
zypper install -y pcre-devel
```

### 安装zlib
```bash
zypper install -y zlib
```

### 安装zlib-devel
```bash
zypper install -y zlib-devel
```


## 安装nginx

### 安装包获取

http://nginx.org/en/download.html


### 解压安装包到nginx目录

```bash
tar zxvf nginx-1.20.2.tar.gz
```

### 编译

```bash
cd nginx-1.20.2

./configure
make
make install
```

### 编译时添加stream模块

```
./configure --with-stream
```

### 编译时添加ssl模块

```
./configure  --with-http_ssl_module
```

### 添加软连接

```bash
ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx
```

### 将服务注册为linux系统服务

```
vim /usr/lib/systemd/system/nginx.service

[Unit]
Description=nginx
[Service]
ExecStart=/usr/bin/nginx
# 指定二进制程序目录及执行时需要加载的配置文件目录
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
```


## 问题参考


### 未安装gcc

```bash
localhost:/usr/local/nginx # ./configure
checking for OS
 + Linux 5.3.18-57-default x86_64
checking for C compiler ... not found

./configure: error: C compiler cc is not found
```

### 未安装pcre或pcre-devel
http模块使用pcre来解析正则表达式，需要在linux上安装pcre库

```bash
./configure: error: the HTTP rewrite module requires the PCRE library.
You can either disable the module by using --without-http_rewrite_module
option, or install the PCRE library into the system, or build the PCRE library
statically from the source with nginx by using --with-pcre=<path> option.
```


### 未安装zlib库

让 nginx 支持 https（即在ssl协议上传输http）

```bash
./configure: error: the HTTP gzip module requires the zlib library.
You can either disable the module by using --without-http_gzip_module
option, or install the zlib library into the system, or build the zlib library
statically from the source with nginx by using --with-zlib=<path> option.
```
