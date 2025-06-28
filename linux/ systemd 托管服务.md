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
|获取默认target|systemctl set-default <target>|

## 配置文件主要由3部分组成，分别是[Unit]、[Service]、[Install]



### [Unit] 段：服务单元基础配置

| ‌**参数**‌             | ‌**作用**‌                                         | ‌**示例值**‌               |
| -------------------- | ------------------------------------------------ | ------------------------ |
| `Description`        | 服务描述信息，显示在 `systemctl status` 输出中26 | `Description=Nginx`      |
| `After` / `Before`   | 定义服务启动顺序（依赖关系）26                   | `After=network.target`   |
| `Requires`           | 强制依赖的服务，若依赖失败则当前服务不启动610    | `Requires=mysql.service` |
| `Wants`              | 弱依赖关系，依赖失败仍启动当前服务610            | `Wants=redis.service`    |
| `Conflicts`          | 指定冲突服务（不可同时运行）610                  | `Conflicts=old-service`  |
| `StartLimitInterval` | 统计重启次数的时间窗口（秒）26                   | `StartLimitInterval=30`  |
| `StartLimitBurst`    | 在 `StartLimitInterval` 内允许的最大重启次数26   | `StartLimitBurst=3`      |

### [Service] 段：服务进程控制

| ‌**参数**‌           | ‌**作用**‌                                                     | ‌**示例值**‌                           |
| ------------------ | ------------------------------------------------------------ | ------------------------------------ |
| `Type`             | 进程类型： `simple`（默认） `forking`（需配 `PIDFile`） `oneshot`（单次执行）26 | `Type=forking`                       |
| `User` / `Group`   | 运行服务的用户和组（建议非 root）610                         | `User=nginx`                         |
| `ExecStart`        | ‌**绝对路径**‌启动命令（必需）26                               | `ExecStart=/usr/sbin/nginx`          |
| `ExecReload`       | 重载配置时执行的命令610                                      | `ExecReload=/bin/kill -HUP $MAINPID` |
| `Restart`          | 重启条件： `no` `on-failure`（默认） `always`26              | `Restart=on-failure`                 |
| `RestartSec`       | 重启前等待时间（秒）26                                       | `RestartSec=5`                       |
| `WorkingDirectory` | 服务的工作目录610                                            | `WorkingDirectory=/var/www`          |
| `Environment`      | 设置环境变量610                                              | `Environment="PATH=/usr/bin"`        |
| `StandardOutput`   | 标准输出目标： `journal`（默认） `file:/path/log`16          | `StandardOutput=journal`             |
| `LimitNOFILE`      | 限制最大文件描述符数量610                                    | `LimitNOFILE=65536`                  |
| `MemoryLimit`      | 内存使用限制（支持 `K`/`M`/`G`）36                           | `MemoryLimit=1G`                     |

### [Install] 段：服务安装与自启

| ‌**参数**‌   | ‌**作用**‌                              | ‌**示例值**‌                   |
| ---------- | ------------------------------------- | ---------------------------- |
| `WantedBy` | 指定关联的 `target`（开机自启依赖） | `WantedBy=multi-user.target` |
| `Alias`    | 服务别名                           | `Alias=web-server.service`   |


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
