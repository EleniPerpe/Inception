FROM debian:bullseye

RUN apt update && apt upgrade && apt install -y \
	php \
	php-mysql \
	curl \
	php7.4-fpm \
	mariadb-client

RUN chmod +x /script.sh

CMD ["./script.sh"]