# 修改用户密码

echo "postgres:密码" | chpasswd

# 创建用户

CREATE USER `用户名` WITH PASSWORD '密码';

#修改用户

psql -U postgres -h 127.0.0.1 -p 5432 -w -c "ALTER USER postgres WITH PASSWORD '密码'"

#创建用户

psql -U postgres -h 127.0.0.1 -p 5432 -w -c "CREATE USER `用户名` WITH PASSWORD '密码'" --password


# 1.sql导入或执行

psql -d `数据库名` -h 127.0.0.1 -p 5432 -U dbName -f /opt/test.sql

#-d 数据库名称

#-h ip地址

#-p 端口号

#-U 用户名

#-f sql文件路径

pg_dump  -h 127.0.0.1 -p 5432 -U `数据库名` -f /opt/test.sql kong


#-h ip地址

#-p 端口号

#-U 用户名

#-f 保存路径

#-d 数据库名称
