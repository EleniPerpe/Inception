#!/bin/bash

set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB database..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

echo "Starting temporary MariaDB instance..."
mysqld_safe --skip-networking --socket=/var/run/mysqld/mysqld.sock &

echo "Waiting for MariaDB to be ready..."
until mysqladmin ping --silent --socket=/var/run/mysqld/mysqld.sock; do
    sleep 1
done

echo "Configuring database..."
mariadb -u root --socket=/var/run/mysqld/mysqld.sock <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASS}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DB}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo "Shutting down temporary instance..."
mysqladmin shutdown --socket=/var/run/mysqld/mysqld.sock -u root

echo "Starting final MariaDB instance..."
exec mysqld