# MySQL数据库全量备份脚本

## Shell命令解析

### date命令

显示或设定系统的日期与时间.

#### 参数

- `-d`:显示时间由字符串描述，而不是当前时间.如：`date -d "1 days"`,表示当前时间1天之后的时间。
- `-s`:通过字符串设置时间。

#### 时间当面

- % : 印出 %
- %n : 下一行
- %t : 跳格
- %H : 小时(00..23)
- %I : 小时(01..12)
- %k : 小时(0..23)
- %l : 小时(1..12)
- %M : 分钟(00..59)
- %p : 显示本地 AM 或 PM
- %r : 直接显示时间 (12 小时制，格式为 hh:mm:ss [AP]M)
- %s : 从 1970 年 1 月 1 日 00:00:00 UTC 到目前为止的秒数
- %S : 秒(00..61)
- %T : 直接显示时间 (24 小时制)
- %X : 相当于 %H:%M:%S
- %Z : 显示时区

#### 日期方面

- %a : 星期几 (Sun..Sat)
- %A : 星期几 (Sunday..Saturday)
- %b : 月份 (Jan..Dec)
- %B : 月份 (January..December)
- %c : 直接显示日期与时间
- %d : 日 (01..31)
- %D : 直接显示日期 (mm/dd/yy)
- %h : 同 %b
- %j : 一年中的第几天 (001..366)
- %m : 月份 (01..12)
- %U : 一年中的第几周 (00..53) (以 Sunday 为一周的第一天的情形)
- %w : 一周中的第几天 (0..6)
- %W : 一年中的第几周 (00..53) (以 Monday 为一周的第一天的情形)
- %x : 直接显示日期 (mm/dd/yy)
- %y : 年份的最后两位数字 (00.99)
- %Y : 完整年份 (0000..9999)

#### 示例

```shell
# 10秒钟之后的时间字符串
 date -d "10 seconds"
 date -d "10 second"
# 10秒钟之前的时间字符串
 date -d "-10 seconds"
 date -d "-10 second"
# 10分钟之前的时间字符串
 date -d "-10 minute"
 date -d "-10 minutes"
# 10分钟之后的时间字符串
 date -d "10 hour"
 date -d "10 hours"
# 10天之后的时间字符串
 date -d "10 day"
 date -d "10 days"
# 10个星期之后的时间字符串
 date -d "10 week"
 date -d "10 weeks"
# 10个月之后的时间字符串
 date -d "10 month"
 date -d "10 months"
# 10年之后的时间字符串
 date -d "10 year"
 date -d "10 years"
 
 
# 10秒钟之后的时间戳
date -d "10 seconds" +%s
```

### stat命令

显示文件或文件系统的状态信息。

#### 参数

- `-t`: 以简洁的方式显示文件信息。
- `-f`：显示文件系统状态。
- `-c <format>`：显示指定样式。

##### `-c`指定的样式

| 符号 | 含义                                                     |
| ---- | -------------------------------------------------------- |
| %a   | 显示文件的八进制权限                                     |
| %A   | 显示以人类可读的权限形式（rwx）                          |
| %b   | 显示已分配的块数（block）                                |
| %B   | 显示每个扇区的大小                                       |
| %C   | 显示安全上下文信息                                       |
| %d   | 显示文件在磁盘中的十进制设备编号                         |
| %D   | 显示文件在磁盘中的十六进制设备编号                       |
| %f   | 显示文件十六进制原始模式                                 |
| %F   | 显示文件类型                                             |
| %g   | 显示用户的GID                                            |
| %G   | 显示用户的属组（组名称）                                 |
| %h   | 显示文件的硬链接数量                                     |
| %i   | 显示文件的inode值                                        |
| %m   | 显示文件所在的挂载点                                     |
| %n   | 显示文件名                                               |
| %N   | 显示文件是否是链接文件，是则显示源文件                   |
| %o   | 显示I/O的传输大小                                        |
| %s   | 显示文件的总大小，以字节bit为单位                        |
| %t   | 显示以十六进制表示的主要设备类型，用于字符和块设备的文件 |
| %T   | 显示以十六进制表示的次要设备类型，用于字符和块设备的文件 |
| %u   | 显示用户的UID                                            |
| %U   | 显示用户的属主（用户名称）                               |
| %w   | 以人类可读显示文件诞生的时间，-表示未知                  |
| %W   | 显示文件诞生的时间，从纪元开始的秒数，若为0表示未知      |
| %x   | 显示文件最后的访问时间                                   |
| %X   | 显示从1970年1月1日到最后访问的秒数                       |
| %y   | 显示文件最后的修改时间                                   |
| %Y   | 显示从1970年1月1日到最后修改的秒数                       |
| %z   | 显示文件最后的改动时间                                   |
| %Z   | 显示从1970年1月1日到最后改动的秒数                       |

### mysqldump命令

[mysqldump命令](./Mysql常用命令.md)




## MySQL数据库全量备份脚本

```sh
#!/bin/bash

#获取当前日期时间作为备份文件名的一部分
DATE=$(date +%Y-%m-%d_%H_%M) 
#要备份的数据库名称
DBNAME="all"
#备份存放目录
BACKUPDIR="/data/db/backup/"
#数据库名称列表
DATABASES="dba dbb dbc"
#用户名
USERNAME=root
#密码
PASSWORD=123456

#参数
PARAMS="--add-drop-database --add-drop-table --add-drop-trigger --flush-logs --single-transaction --master-data=2"

FILE="$BACKUPDIR$DBNAME-$DATE.sql.gz"
 
if [ ! -d "$BACKUPDIR" ]; then
    mkdir -p $BACKUPDIR       #创建备份存放目录（若不存在）
fi

echo "开始备份..."
mysqldump --user=$USERNAME --password=$PASSWORD $PARAMS  --databases $DATABASES  | gzip  > $FILE
echo "备份完成！" 

echo "开始清除多余的备份文件，默认备份一年"

cd $BACKUPDIR

#获取当前时间，减去365的时间戳
cutoff=$(date -d "-365 days" +%s)
#cutoff=$(date -d "-1 days" +%s)
#cutoff=$(date -d "-1 min" +%s)

for file in "$BACKUPDIR"* 
do
	modtime=$(stat -c %Y "$file")
        if [ "$modtime" -lt "$cutoff" ]
        then 
		echo "delete file:$file"
		rm "$file"
	fi
done

echo "清除多余的备份文件完成"

```
