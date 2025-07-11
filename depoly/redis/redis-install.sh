#!/bin/bash
#redis安装脚本
PKGBASE=`pwd`

# 1.安装依赖
echo "********************1.安装依赖*************************"
yum install -y gcc tcl

# 2.解压安装
echo "********************2.解压安装*************************"
if ! [ -f "redis-5.0.13.tar.gz" ]; then
    echo "错误：未找到redis-5.0.13.tar.gz文件"
    exit 1
fi

tar -zxvf redis-5.0.13.tar.gz || { echo "解压失败"; exit 1; }

cd redis-5.0.13 || { echo "进入目录失败"; exit 1; }

# 3.编译安装
echo "********************3.编译安装*************************"
make && make USE_SYSTEMD=yes PREFIX=/usr/local/redis install || { echo "编译失败"; exit 1; }

# 4.配置Redis
echo "********************4.配置Redis*************************"
mkdir -p /usr/local/redis/conf
cp redis.conf /usr/local/redis/conf/
cd /usr/local/redis/conf

sed -i '69s/bind 127.0.0.1/#bind 127.0.0.1/' redis.conf
sed -i 's/# requirepass foobared/requirepass password/' redis.conf
sed -i 's|supervised no|supervised systemd|g' redis.conf

# 5.创建软链接
echo "********************5.创建软链接*************************"
ln -sf /usr/local/redis/bin/redis-server /usr/bin/redis-server

# 6.配置自启服务
echo "********************6.配置自启服务*************************"

cd $PKGBASE ||exit 1
cp -rf redis.service /usr/lib/systemd/system/redis.service

# 重新加载systemd配置
systemctl daemon-reload

# 启动并启用NameServer服务
systemctl start redis.service  
systemctl enable redis.service


# 7.开启防火墙端口
echo "********************7.开启防火墙端口*************************"
firewall-cmd --zone=public --add-port=6379/tcp --permanent
firewall-cmd --reload

echo "********************Redis安装成功*************************"
echo "Redis已启动，端口：6379，密码：password"
