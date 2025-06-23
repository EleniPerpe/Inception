#!/bin/bash

mkdir -p "/etc/nginx/ssl"

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    	-keyout "/etc/nginx/ssl/key.pem" \
    	-out "/etc/nginx/ssl/fullchain.pem" \
	-subj "/C=DE/ST=Baden-Wuerttemberg/L=Heilbronn/OU=42 Heilbronn Students/CN=eperperi.42.fr"

cat > "/etc/nginx/sites-available/default" <<EOF
server {
    listen 80 default_server;
    server_name _;
    return 404;
}

server {
    listen 443 ssl default_server;
    server_name _;
    ssl_certificate $/etc/nginx/ssl/fullchain.pem;
    ssl_certificate_key $/etc/nginx/ssl/key.pem;
    return 404;
}

server {
    listen 443 ssl;
    server_name "eperperi.42.fr" "www.eperperi.42.fr";
    root /var/www/html;
    index index.php;

    ssl_certificate $/etc/nginx/ssl/fullchain.pem;
    ssl_certificate_key $/etc/nginx/ssl/key.pem;
    ssl_protocols TLSv1.3;

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass wordpress:9000;
    }
}
EOF

ln -sf "/etc/nginx/sites-available/default" "/etc/nginx/sites-enabled/default"
nginx -t