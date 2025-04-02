#!/bin/bash

cd /var/www/html

# Download WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

# Wait for MariaDB to be ready
# until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
#     echo "Waiting for MariaDB to be ready..."
#     sleep 5
# done

# Download and configure WordPress
./wp-cli.phar core download --allow-root
./wp-cli.phar config create \
    --dbname="$WORDPRESS_DB_NAME" \
    --dbuser="$WORDPRESS_DB_USER" \
    --dbpass="$WORDPRESS_DB_PASSWORD" \
    --dbhost="$WORDPRESS_DB_HOST" \
    --allow-root
./wp-cli.phar core install \
    --url="$WP_URL" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --allow-root


# Add a sample post
./wp-cli.phar post create \
    --post_title="Sample Post" \
    --post_content="This is a sample post created during initialization." \
    --post_status=publish \
    --post_author=1 \
    --allow-root

# Add a regular WordPress user
./wp-cli.phar user create \
    "$WP_USER" "$WP_USER_EMAIL" \
    --role=editor \
    --user_pass="$WP_PASS" \
    --allow-root

# Start PHP-FPM
php-fpm8.2 -F