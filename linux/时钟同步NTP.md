# 时钟同步

## 部署安装

```
yum install -y ntp
```

## 修改配置

### 修改服务端配置

```bash
# 设置允许某网段服务器进行同步
restrict 192.168.10.91 mask 255.255.255.252 nomodify notrap

# 设置同步的ntp服务器
server ntp.aliyun.com iburst


# 设置服务器无法同步外网时间就和本地系统时间同步
server 127.127.1.0
fudge 127.127.1.0 stratum 10

```

### 修改客户端配置

```bash
# 将ip指向服务端ip
server 192.168.10.92 iburst
```


## 开放端口

```
firewall-cmd --add-port=123/udp --permanent
firewall-cmd --reload
```

## 常用命令

### 查看ntp连接状态

#### `ntpq -p`

```bash
[root@localhost ~]# ntpq -p
     remote           refid      st t when poll reach   delay   offset  jitter
==============================================================================
*192.168.0.11   203.107.6.88     3 u  140  512  377    0.102  -14.062   4.306
```

- remote：响应这个请求的NTP服务器的名称。
- refid：NTP服务器使用的上一级ntp服务器。
- st ：remote远程服务器的级别.由于NTP是层型结构,有顶端的服务器,多层的Relay Server再到客户端.所以服务器从高到低级别可以设定为1-16.为了减缓负荷和网络堵塞,原则上应该避免直接连接到级别为1的服务器的.
- when: 上一次成功请求之后到现在的秒数。
- poll : 本地机和远程服务器多少时间进行一次同步(单位为秒).在一开始运行NTP的时候这个poll值会比较小,那样和服务器同步的频率也就增加了,可以尽快调整到正确的时间范围，之后poll值会逐渐增大,同步的频率也就会相应减小
- reach:这是一个八进制值,用来测试能否和服务器连接.每成功连接一次它的值就会增加
- delay:从本地机发送同步要求到ntp服务器的round trip time
- offset：主机通过NTP时钟同步与所同步时间源的时间偏移量，单位为毫秒（ms）。offset越接近于0,主机和ntp服务器的时间越接近
- jitter:这是一个用来做统计的值.它统计了在特定个连续的连接数里offset的分布情况.简单地说这个数值的绝对值越小，主机的时间就越精确





