# yum

## yum包管理器

### 源文件地址

```sh
/etc/yum.repos.d
```

### 显示已配置的源

```
yum repolist
```


### 重新生成缓存

yum clean all

yum makecache

### 设置阿里云源仓库

```
wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo

yum clean all

yum makecache
```

### 设置docker阿里云镜像加速地址

yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo


## Docker 卸载升级

yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine

yum install docker-ce docker-ce-cli containerd.io

