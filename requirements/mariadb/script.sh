#!/bin/bash

# Initialize the MariaDB data directory
mysql_install_db

# Start the MariaDB server in the background
mysqld --skip-networking &
mariadb_pid=$!

# Wait for MariaDB to be ready
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done

# Use environment variables to create the database, user, and grant privileges
mysql -u root <<-EOSQL
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

# Stop the MariaDB server
kill "$mariadb_pid"
wait "$mariadb_pid"

# Restart MariaDB in the foreground
exec mysqld