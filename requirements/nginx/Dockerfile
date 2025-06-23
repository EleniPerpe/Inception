FROM debian:bullseye

RUN apt update && apt upgrade && apt install -y \
	nginx openssl

RUN	mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    	-keyout "$SSL_DIR/key.pem" \
    	-out "$SSL_DIR/fullchain.pem" \
	-subj "/C=DE/ST=Baden-Wuerttemberg/L=Heilbronn/OU=42 Heilbronn Students/CN=eperperi.42.fr"


COPY default /etc/nginx/sites-available/.

RUN chmod +x /startup.sh 

CMD ["sh", "-c", "/startup.sh && nginx -g 'daemon off;'"]