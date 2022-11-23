# JAVA安装文档

### 创建java目录

```bash
mkdir /usr/local/java
```

### 解压到刚刚的安装目录

```bash
tar zxvf jdk-8u241-linux-x64.tar.gz -C /usr/local/java/
```

### 配置环境变量

```bash
export JAVA_HOME=/usr/local/java/jdk1.8.0_241
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:${PATH}
```

### 使环境变量生效

```bash
source /etc/profile
```

### 添加软连接

```bash
ln -s /usr/local/java/jdk1.8.0_241/bin/java /usr/bin/java
```

### 检查java版本

```bash
java -version
```