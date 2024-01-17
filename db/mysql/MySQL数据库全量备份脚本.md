# MySQL数据库全量备份脚本

## Shell命令解析





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
