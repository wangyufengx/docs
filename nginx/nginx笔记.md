# nginx笔记

## 如何同时加载nginx.conf与conf.d中的配置

```
include /etc/nginx/conf.d/*.conf;
```