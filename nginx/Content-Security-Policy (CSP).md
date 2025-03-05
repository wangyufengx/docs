# Content-Security-Policy (CSP)

**Content-Security-Policy（CSP）是一种基于白名单机制的安全策略，通过限制网页可加载资源的来源和类型，防御跨站脚本攻击（XSS）、点击劫持等安全威胁‌**

## 语法

```http
Content-Security-Policy: <policy-directive>; <policy-directive>
```

其中 <policy-directive> 应为不含标点的 <directive> <value> 形式。

## 指令及作用

|指令|作用|
|:---:|:---:|
|connect-src|定义针对 Ajax/WebSocket 等请求的加载策略。不允许的情况下，浏览器会模拟一个状态为400的响应。|
|default-src	|义针对所有类型（js/image/css/font/ajax/iframe/多媒体等）资源的默认加载策略，如果某类型资源没有单独定义策略，就使用默认的。|
|script-src|定义针对 JavaScript 的加载策略。|
|style-src|定义针对样式的加载策略。|
|img-src|定义针对图片的加载策略。|
|frame-src|针对 frame 的加载策略。|
|report-uri	|告诉浏览器如果请求的资源不被策略允许时，往哪个地址提交日志信息。|


## CSP 指令值

|指令值|	说明|
|* |	允许加载任何内容|
|'none'	|不允许加载任何内容|
|'self'|	允许加载相同源的内容|
|www.a.com|	允许加载指定域名的资源|
|*.a.com	|允许加载 a.com 任何子域名的资源|
|https://a.com |	允许加载 a.com 的 https 资源|
|https：|	允许加载 https 资源|
|data：|	允许加载 data: 协议，例如：base64编码的图片|
|'unsafe-inline'	|允许加载 inline 资源，例如style属性、onclick、inline js、inline css等|
|'unsafe-eval'	|允许加载动态 js 代码，例如 eval()|


## 参考文档

[Content-Security-Policy (CSP)](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/Content-Security-Policy)

[Web 安全之内容安全策略（Content-Security-Policy,CSP）详解](https://www.cnblogs.com/mutudou/p/14373644.html)
