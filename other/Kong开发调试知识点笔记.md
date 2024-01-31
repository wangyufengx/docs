# Kong开发调试知识点笔记

## 日志级别（从高到低）

- `crit`
- `error`
- `warn`
- `notice`
- `info`
- `debug`

`kong`默认的日志级别是`notice`



## kong自定义插件优先级(priority)

priority越大优先级越高。

```go
const Priority = 1
```



## kong 自带插件的优先级

| 插件名称                | 优先级 |
| ----------------------- | ------ |
| acl                     | 950    |
| acme                    | 1705   |
| ai-prompt-decorator     | 772    |
| ai-prompt-guard         | 771    |
| ai-prompt-template      | 773    |
| ai-proxy                | 770    |
| ai-request-transformer  | 777    |
| ai-response-transformer | 769    |
| aws-lambda              | 750    |
| azure-functions         | 749    |
| basic-auth              | 1100   |
| bot-detection           | 2500   |
| correlation-id          | 1      |
| cors                    | 2000   |
| datalog                 | 10     |
| file-log                | 9      |
| grpc_gateway            | 998    |
| grpc_web                | 3      |
| hmac-auth               | 1030   |
| http-log                | 12     |
| ip-restriction          | 990    |
| jwt                     | 1450   |
| key-auth                | 1250   |
| ldap-auth               | 1200   |
| loggly                  | 6      |
| oauth2                  | 1400   |
| opentelemetry           | 14     |
| prometheus              | 13     |
| proxy-cache             | 100    |
| rate-limiting           | 910    |
| request-size-limiting   | 951    |
| request-termination     | 2      |
| request-transformer     | 801    |
| response-ratelimiting   | 900    |
| response-transformer    | 800    |
| session                 | 1900   |
| statsd                  | 11     |
| syslog                  | 4      |
| tcp-log                 | 7      |
| udp-log                 | 8      |
| zipkin                  | 100000 |

