# SpringBoot获取配置的几种方式

配置文件为bootstrap.yml

```yaml
server:
  port: 9999

aaa:
  value: test
```

## 使用`@ConfigurationProperties`注解

在`application.properties`或`application.yml`中使用前缀指定属性，然后通过`@ConfigurationProperties`注解将属性映射到Java类中。

````java
package com.example.demo1.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;


@Data
@Component
@ConfigurationProperties(prefix = "aaa")
public class CustomListConfig {
    private String value;
}

````

## 使用`@Value`注解

使用`@Value`注解可以直接将配置文件中的值注入到Java类的字段中。

```java
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class MyComponent {

    @Value("${aaa.value}")
    private String propertyValue;

    // getter和setter方法
}
```

## 使用`Environment`接口

可以通过`Environment`接口的`getProperty`方法来获取配置文件中的属性值。

```java
import jakarta.annotation.Resource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

@Component
public class MyComponent {

    @Resource
    private Environment environment;

    public void someMethod() {
        String value = environment.getProperty("aaa.value");
    }
}
```

## 使用`@PropertySource`注解

使用`@PropertySource`注解指定自定义的属性文件，然后通过`@Value`注解获取属性值。

```java
package com.example.demo1.config;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;


@Data
@Component
@PropertySource(value = "classpath:bootstrap.yml")
public class CustomListConfig {
    @Value("${aaa.value}")
    private String value;
}

```

