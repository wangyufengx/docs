# nginx笔记

## 如何同时加载nginx.conf与conf.d中的配置

```
include /etc/nginx/conf.d/*.conf;
```

## websocket长连接配置


```
map $http_upgrade $connection_upgrade {
          default upgrade;
          '' close;
}


server {
	...
	location / {
		...
		proxy_http_version 1.1;
		proxy_set_header Upgrade $http_upgrade;
		proxy_set_header Connection $connection_upgrade;
	}
}
```

## 生成测试的ssl证书

### 生成密钥
```
openssl genrsa -out yourdomain.key 2048
```

### 生成证书签名请求（CSR）
```
openssl req -new -key yourdomain.key -out yourdomain.csr
```

### 生成自签名证书（crt）
```
openssl x509 -req -days 365 -in yourdomain.csr -signkey yourdomain.key -out yourdomain.crt
```

## 开启https

ssl_certificate：证书公钥
ssl_certificate_key：证书私钥
ssl_session_timeout：会话缓存中ssl参数的过期时间
sl_session_cache shared:SSL:10m; : 设置ssl/tls会话缓存的类型和大小。

```
server {
	  listen 443 ssl;
      server_name  localhost;
      absolute_redirect off;

      ssl_certificate      /etc/nginx/9266483_zcode.hzsun.com.crt;
      ssl_certificate_key  /etc/nginx/9266483_zcode.hzsun.com.key;

      ssl_session_cache    shared:SSL:1m;
      ssl_session_timeout  5m;

}

```

### stream 模块使用

```
stream {
	server {
	
	}
}
```

### 全局变量

```
$scheme:// 请求的协议
```

## 80重定向到443
```
server {
  listen   80;
  server_name  domain;
  return   301 https://$server_name$request_uri;
}
```

## 默认转发

```
location = / {
  rewrite ^(.*)$  http:/$host/hello/nginx$1 permanent;
}
```

## ERR_RESPONSE_HEADERS_MULTIPLE_CONTENT_DISPOSITION错误

该错误通常发生在浏览器下载文件时，因响应头设置不当导致解析冲突。以下是具体分析和解决方案：

### 错误原因分析
‌
- 特殊字符引发解析歧义‌：当文件名包含逗号、分号等特殊符号时，浏览器可能误判为多个响应头声明24。例如filename=test(x,y).docx会被拆分为filename=test(x和y).docx两部分2。
- 重复设置响应头‌：服务端代码可能多次设置Content-Disposition头，导致浏览器接收多个冲突指令6。
- 引号缺失问题‌：未用引号包裹含特殊符号的文件名，浏览器会触发安全机制拦截请求

### 强制覆盖响应头

```
 proxy_hide_header Content-Disposition;
 add_header Content-Disposition 'attachment; filename="$arg_filename"';
```
