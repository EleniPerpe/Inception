#!/bin/bash

mkdir -p "/etc/nginx/ssl"

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    	-keyout "/etc/nginx/ssl/key.pem" \
    	-out "/etc/nginx/ssl/fullchain.pem" \
	-subj "/C=DE/ST=Baden-Wuerttemberg/L=Heilbronn/OU=42 Heilbronn Students/CN=eperperi.42.fr"

ln -sf "/etc/nginx/sites-available/default" "/etc/nginx/sites-enabled/default"
nginx -t