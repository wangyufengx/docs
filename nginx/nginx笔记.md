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