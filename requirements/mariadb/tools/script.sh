#!/bin/bash

set -e

service mariadb start

until mariadb-admin ping --silent; do
  sleep 1
done

mariadb -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASS}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DB}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

mysqladmin shutdown --socket=/var/run/mysqld/mysqld.sock -u root

exec mysqld