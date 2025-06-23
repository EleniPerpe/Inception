FROM debian:bullseye

RUN apt update && apt upgrade && apt install -y \
	php \
	php-mysql \
	curl \
	php7.4-fpm \
	mariadb-client

COPY script.sh .

RUN chmod +x /script.sh

EXPOSE 9000

CMD ["./script.sh"]