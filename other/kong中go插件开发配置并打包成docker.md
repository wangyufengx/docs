# kong中go插件开发配置并打包成docker

**本方法适用于kong 2.7版本以上**

## kong服务器安装时的配置

### go语言开发插件

kong提供了go语言的插件开发工具包[go-pdk]("github.com/Kong/go-pdk")

示例`go-hello`插件：

```go
/*
	A "hello world" plugin in Go,
	which reads a request header and sets a response header.
*/

package main

import (
	"fmt"
	"log"

	"github.com/Kong/go-pdk"
	"github.com/Kong/go-pdk/server"
)

func main() {
	server.StartServer(New, Version, Priority)
}

var Version = "0.2"
var Priority = 1

type Config struct {
	Message string
}

func New() interface{} {
	return &Config{}
}

func (conf Config) Access(kong *pdk.PDK) {
	host, err := kong.Request.GetHeader("host")
	if err != nil {
		log.Printf("Error reading 'host' header: %s", err.Error())
	}

	message := conf.Message
	if message == "" {
		message = "hello"
	}
	kong.Response.SetHeader("x-hello-from-go", fmt.Sprintf("Go says %s to %s", message, host))
}
```

### `kong.conf.default`配置修改

```conf
pluginserver_names = go-hello

pluginserver_go_socket = /usr/local/kong/go-hello.sock
pluginserver_go_start_cmd = /usr/local/bin/go-hello -kong-prefix /usr/local/kong
pluginserver_go_query_cmd = /usr/local/bin/go-hello -dump -kong-prefix /usr/local/kong
```

添加插件名到 `plugins`配置中

```conf
plugins = bundled, go-hello
```

### 修改`constant.lua`文件

文件位置 `/usr/local/share/lua/5.1/kong/constants.lua`

在local plugins中添加`go-hello`插件名。

```lua
local plugins = {
    "go-hello",
    }
```

到此kong已经安装完成了。修改连接postgre后，就可以执行`kong migrations`


## docker打包集成

### Dockerfile

```Dockerfile

FROM docker.io/library/golang:1.18.3-alpine3.15 AS builder


RUN mkdir -p /tmp/go/src/ \
    && go env -w GOPROXY=https://goproxy.cn,direct

COPY plugins-code/ /tmp/go/src
COPY kong.conf.default /tmp/go/src/kong.conf.default

RUN cd /tmp/go/src/go-hello  \
    && go mod tidy \
    && go build -o go-hello \
    && ls /tmp/go/src/go-hello

FROM kong:2.8.1-alpine
USER root
COPY --from=builder  /tmp/go/src/go-hello/go-hello /usr/local/bin/
COPY --from=builder  /tmp/go/src/kong.conf.default /etc/kong/kong.conf.default
RUN sed -i 's|local plugins = {|local plugins = {\n  "go-hello",|g' /usr/local/share/lua/5.1/kong/constants.lua

```

### deploy

```deploy.sh
# 删除容器
docker rm -f `docker ps -a|grep kong:2.8.0-personalise|awk '{print $1}'`
#删除镜像
docker rmi -f `docker images --filter=reference='kong:2.8.0-personalise' | awk '{print $3}'`

# 进入容器
#  docker exec -it `docker ps |grep kong:2.8.0-personalise |awk '{print $1}'`  /bin/sh

chmod +x kong/install.sh

docker build -f Dockerfile . -t kong:2.8.0-personalise
```

### run

```bash
docker run --rm  \
    -p 8000:8000 \
    -p 8001:8001 \
    -p 8443:8443 \
    -p 8444:8444 \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_PG_PORT=5432" \
    -e "KONG_PG_HOST={IP}" \
    -e "KONG_PG_DATABASE=kong" \
    -e "KONG_PG_USER=postgres" \
    -e "KONG_PG_PASSWORD=kong" \
    -e "KONG_PLUGINS=bundled, go-hello" \
    -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" \
    kong:2.8.0-personalise kong migrations bootstrap -c /etc/kong/kong.conf.default

docker run -d --name kong --restart=no \
    -p 8000:8000 \
    -p 8001:8001 \
    -p 8443:8443 \
    -p 8444:8444 \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_PG_PORT=5432" \
    -e "KONG_PG_HOST={IP}" \
    -e "KONG_PG_DATABASE=kong" \
    -e "KONG_PG_USER=postgres" \
    -e "KONG_PG_PASSWORD=kong" \
    -e "KONG_PLUGINS=bundled, go-hello" \
    -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" \
    kong:2.8.0-personalise kong start -c /etc/kong/kong.conf.default
```

### docker compose
```docker-compose.yml
services:
  kong:
    image: "ctrimages.hzlinks4.net/library/kong:3.4.2-personalise"
    container_name: "kong-3.4.2"
    ports:
      - "8000:8000"
      - "8001:8001"
      - "8002:8002"
      - "8443:8443"
      - "8444:8444"
      - "8445:8445"
    environment:
      - TZ=Asia/Shanghai
      - KONG_DATABASE=postgres
      - KONG_PG_PORT=5432
      - KONG_PG_HOST={IP}
      - KONG_PG_DATABASE=kong
      - KONG_PG_USER=postgres
      - KONG_PG_PASSWORD=kong
      - KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl
      - KONG_ADMIN_GUI_LISTEN=0.0.0.0:8002, 0.0.0.0:8445 ssl
      - KONG_ADMIN_GUI_URL=http://{IP}:8002/manager
      - KONG_ADMIN_GUI_PATH=/manager
    restart: always
    command: "kong start -c /etc/kong/kong.conf.default"
```


### 参考资料

https://github.com/Kong/go-plugins

https://docs.konghq.com/gateway/latest/install-and-run/centos/

https://docs.konghq.com/gateway/latest/reference/external-plugins/
