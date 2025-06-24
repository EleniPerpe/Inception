FROM debian:bullseye

RUN apt update && apt upgrade && apt install -y \
	nginx openssl

RUN	mkdir -p /etc/nginx/ssl

COPY default /etc/nginx/sites-available/default

COPY default /etc/nginx/sites-enabled/default
	
COPY startup.sh .

RUN chmod +x ./startup.sh 

CMD ["sh", "-c", "/startup.sh && nginx -g 'daemon off;'"]