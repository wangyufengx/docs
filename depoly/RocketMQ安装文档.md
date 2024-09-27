# RocketMQ安装文档

## 安装脚本

```bash
#/bin/bash

read -p "请输入本机IP：" IP
echo "本机IP为: $IP"


# 1. 安装依赖  


# 2.解压安装  
if ! [ -f "rocketmq-all-5.3.0-bin-release.tar.gz" ]; then  
    echo "未找到rocketmq-all-5.3.0-bin-release.tar.gz文件"  
    exit 1  
fi
tar zxvf rocketmq-all-5.3.0-bin-release.tar.gz

cd ./rocketmq-all-5.3.0-bin-release/conf || exit 1  

sed -i 's|brokerClusterName = DefaultCluster|brokerClusterName = broker|g' broker.conf
echo "namesrvAddr = $IP:9876" >> broker.conf  
echo "brokerIP1 = $IP" >> broker.conf  

echo "RocketMQ配置已更新。"

cd ../bin ||exit 1

# 修改启动脚本中的JVM参数
sed -i 's|JAVA_OPT="${JAVA_OPT} -server -Xms4g -Xmx4g -Xmn2g -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=320m"|JAVA_OPT="${JAVA_OPT} -server -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=320m"|g' runserver.sh

sed -i 's|JAVA_OPT="${JAVA_OPT} -server -Xms4g -Xmx4g -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=320m"|JAVA_OPT="${JAVA_OPT} -server -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=320m"|g' runserver.sh

sed -i 's|JAVA_OPT="${JAVA_OPT} -server -Xms8g -Xmx8g"|JAVA_OPT="${JAVA_OPT} -server"|g' runbroker.sh

sed -i 's|JAVA_OPT="${JAVA_OPT} -Xmn4g -XX:+UseConcMarkSweepGC -XX:+UseCMSCompactAtFullCollection -XX:CMSInitiatingOccupancyFraction=70 -XX:+CMSParallelRemarkEnabled -XX:SoftRefLRUPolicyMSPerMB=0 -XX:+CMSClassUnloadingEnabled -XX:SurvivorRatio=8 -XX:-UseParNewGC"|JAVA_OPT="${JAVA_OPT} -XX:+UseConcMarkSweepGC -XX:+UseCMSCompactAtFullCollection -XX:CMSInitiatingOccupancyFraction=70 -XX:+CMSParallelRemarkEnabled -XX:SoftRefLRUPolicyMSPerMB=0 -XX:+CMSClassUnloadingEnabled -XX:SurvivorRatio=8 -XX:-UseParNewGC"|g' runbroker.sh

echo "启动脚本修改完成"

cd .. || exit 1

mkdir -p logs

# 使用nohup和&后台运行服务，并将输出重定向到日志文件
nohup sh ./bin/mqnamesrv >logs/mqnamesrv.log 2>&1 &
nohup sh ./bin/mqbroker -n "$IP:9876" autoCreateTopicEnable=true -c conf/broker.conf &>logs/broker.log 2>&1 &
echo "RocketMQ服务已启动，日志保存在logs目录下。"

firewall-cmd --add-port=9876/tcp --add-port=10911/tcp --permanent
firewall-cmd --reload

```
