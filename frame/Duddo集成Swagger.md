# Dubbo集成Knife4j (Swagger 生成doc.html)

Apache Dubbo™ 是一款高性能Java RPC框架。Apache Dubbo Spring Boot Project使得使用Dubbo作为RPC框架轻松创建Spring Boot应用程序。更重要的是，它还提供:

- 自动配置特性(例如，注释驱动、自动配置、外部化配置)。
- Production-Ready (比如： 安全, 健康检查, 外部化配置等).

Swagger 是一个规范和完整的框架，用于生成、描述、调用和可视化 RESTful 风格的 Web 服务。总体目标是使客户端和文件系统作为服务器以同样的速度来更新。文件的方法、参数和模型紧密集成到服务器端的代码，允许 API 来始终保持同步。Swagger 让部署管理和使用功能强大的 API 从未如此简单。

Knife4j是一个集Swagger2 和 OpenAPI3 为一体的增强解决方案。帮助开发者快速聚合使用OpenAPI规范。

## 引入依赖

集成SpringBoot

```xml
<dependency>
    <groupId>org.apache.dubbo</groupId>
    <artifactId>dubbo-spring-boot-starter</artifactId>
    <version>3.0.0</version>
</dependency>
```

集成Knife4j

```xml
<dependency>
    <groupId>com.github.xiaoymin</groupId>
    <artifactId>knife4j-spring-boot-starter</artifactId>
    <version>3.0.3</version>
</dependency>
```

## Swagger配置

```java
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@EnableSwagger2
@Configuration
@Slf4j
public class SwaggerConfig implements WebMvcConfigurer {

    @Bean
    public Docket userSecurity() {
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .groupName("Spring Dubbo Swagger")
                .select()
                //此包路径下的类，才生成接口文档
                .apis(RequestHandlerSelectors.basePackage("com.wyf.study"))
                //加了ApiOperation注解的类，才生成接口文档
                .apis(RequestHandlerSelectors.withMethodAnnotation(ApiOperation.class))
                .paths(PathSelectors.ant("/**"))
                .build();

        //.globalOperationParameters(setHeaderToken());
    }

    /**
     * api文档的详细信息
     *
     * @return
     */
    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("XX项目")
                .description(" API 1.0 操作文档")
                .termsOfServiceUrl("")
                .version("1.0")
                .license("Apache 2.0")
                .licenseUrl("http://www.apache.org/licenses/LICENSE-2.0")
                .contact(new Contact("Hello Swagger", "https://www.baidu.com", "xxx@qq.com"))
                .build();
    }
}
```

## 创建Controller

```java
@RestController
@Api(tags = "测试")
@RequestMapping("/hello")
public class HelloController {

    @GetMapping
    @ApiOperation("Hello")
    public String hello(){
        return "hello world";
    }
}
```

万事俱备，启动Spring Boot项目，浏览器访问Knife4j的文档地址即可查看效果

```
http://localhost:8080/doc.html
```



## 参考文档

https://github.com/apache/dubbo-spring-boot-project/blob/master/README_CN.md

https://doc.xiaominfo.com/