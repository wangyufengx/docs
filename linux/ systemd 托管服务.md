#  systemd 托管服务

## 常用管理命令

|操作|命令|
|:---:|:---:|
|启动服务|systemctl start service_name|
|停止服务|	sudo systemctl stop service_name|
|重启服务|	sudo systemctl restart service_name|
|查看状态|	sudo systemctl status service_name|
|查看服务配置文件|systemctl cat service_name
|实时日志|	journalctl -u service_name -f 23|
|禁用开机自启|	sudo systemctl disable service_name|
|查看本次启动日志|journalctl -u service_name -b|



## 配置参数

|:---:|:---:|:---:|
|参数|作用|默认值|
|StartLimitInterval|	定义时间窗口（秒），在此时间段内统计重启次数| 10s|
|



```bash
cat > /usr/lib/systemd/system/nginx.service << EOF

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
EOF
```
