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

      ssl_certificate      /etc/nginx/9266483_zcode.hzsun.com.pem;
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

