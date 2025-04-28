# MySQL主从搭建

## 配置修改

### 主库配置
```vim /etc/my.cnf
#增加的配置
log-bin=master-bin
#修改的配置,server-id从库与主库的不能一样
server-id=1001
```

重启数据库

### 从库配置
```vim /etc/my.cnf
#修改的配置,server-id从库与主库的不能一样
server-id=2002
relay-log=relay-log           # 启用中继日志
read_only=1                   # 可选：限制从库只读
```

重启数据库

## 锁库

进入主库，锁库。

FLUSH table with read lock;

## 查看master状态，pos并记录

show master status;
```
MariaDB [(none)]> show master status;
+-------------------+----------+--------------+------------------+
| File              | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+-------------------+----------+--------------+------------------+
| master-bin.000042 | 98680033 |              |                  |
+-------------------+----------+--------------+------------------+
1 row in set (0.000 sec)
```

show variables like "%log_bin";
```
MariaDB [(none)]> show variables like '%log_bin';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| log_bin       | ON    |
| sql_log_bin   | ON    |
+---------------+-------+
2 rows in set (0.001 sec)

```
### 创建同步数据用户
```
CREATE USER 'repl_user'@'%' IDENTIFIED BY 'password';
GRANT REPLICATION SLAVE ON *.* TO 'repl_user'@'%';
FLUSH PRIVILEGES;
```

## 导出

主库服务器另开一个页面导出数据库。

mysqldump -h 127.0.0.1 -uroot -p42a2fd817cd --add-drop-database --add-drop-table --add-drop-trigger --flush-logs --single-transaction --master-data=2 --all-databases > all-$(date +%F).sql

将导出的脚步发送到从库所在服务器

## 停止slave

进入从库停止slave。

stop slave


## 导入

mysql -h 172.16.4.199 -uroot -p42a2fd817cd < all-$(date +%F).sql

## 设置开始同步位置

 CHANGE MASTER TO 
  MASTER_HOST='172.16.4.199', 
  MASTER_USER='repl_user',
  MASTER_PASSWORD='password',
  MASTER_PORT=6006,
  MASTER_LOG_FILE='mysql-bin.000042', 
  MASTER_LOG_POS=98680033;

## 开启同步

start slave;

## 查看状态

show slave status \G

```

MariaDB [(none)]> show slave status\G
*************************** 1. row ***************************
                Slave_IO_State: 
                   Master_Host: 127.0.0.1
                   Master_User: replication_user
                   Master_Port: 6006
                 Connect_Retry: 60
               Master_Log_File: master-bin.000001
           Read_Master_Log_Pos: 194248283
                Relay_Log_File: mysqld-relay-bin.000007
                 Relay_Log_Pos: 4
         Relay_Master_Log_File: master-bin.000001
              Slave_IO_Running: YES
             Slave_SQL_Running: YES
               Replicate_Do_DB: pub
           Replicate_Ignore_DB: 
            Replicate_Do_Table: 
        Replicate_Ignore_Table: 
       Replicate_Wild_Do_Table: 
   Replicate_Wild_Ignore_Table: 
                    Last_Errno: 0
                    Last_Error: 
                  Skip_Counter: 0
           Exec_Master_Log_Pos: 194248283
               Relay_Log_Space: 194250169
               Until_Condition: None
                Until_Log_File: 
                 Until_Log_Pos: 0
            Master_SSL_Allowed: No
            Master_SSL_CA_File: 
            Master_SSL_CA_Path: 
               Master_SSL_Cert: 
             Master_SSL_Cipher: 
                Master_SSL_Key: 
         Seconds_Behind_Master: NULL
 Master_SSL_Verify_Server_Cert: No
                 Last_IO_Errno: 0
                 Last_IO_Error: 
                Last_SQL_Errno: 0
                Last_SQL_Error: 
   Replicate_Ignore_Server_Ids: 
              Master_Server_Id: 0
                Master_SSL_Crl: 
            Master_SSL_Crlpath: 
                    Using_Gtid: No
                   Gtid_IO_Pos: 
       Replicate_Do_Domain_Ids: 
   Replicate_Ignore_Domain_Ids: 
                 Parallel_Mode: optimistic
                     SQL_Delay: 0
           SQL_Remaining_Delay: NULL
       Slave_SQL_Running_State: 
              Slave_DDL_Groups: 0
Slave_Non_Transactional_Groups: 0
    Slave_Transactional_Groups: 0
1 row in set (0.000 sec)

MariaDB [(none)]> 
```

> Slave_IO_Running: YES
> Slave_SQL_Running: YES
> 以上两个YES则表示主从搭建成功。可以通过在主库新增，从库查看验证。
