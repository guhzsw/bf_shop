#!/bin/bash

# 启动MySQL
service mysql start

# 等待MySQL启动
while ! mysqladmin ping -h"localhost" --silent; do
    sleep 1
done

# 创建数据库和用户
mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME:-bf_shop};
CREATE USER IF NOT EXISTS '${DB_USER:-bf_shop_user}'@'localhost' IDENTIFIED BY '${DB_PASS:-bf_shop_password}';
GRANT ALL PRIVILEGES ON ${DB_NAME:-bf_shop}.* TO '${DB_USER:-bf_shop_user}'@'localhost';
FLUSH PRIVILEGES;
EOF

# 启动Apache和Supervisor
/usr/bin/supervisord -n
