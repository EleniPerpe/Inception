FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y \
	mariadb-server \
	curl \
	gettext \
	openssl \
	&& rm -rf /var/lib/apt/lists/*
	
RUN sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/script.sh .

RUN mkdir -p /docker-entrypoint-initdb.d \
    /run/mysqld \
    /etc/mysql/mariadb.conf.d && \
	chmod +x /script.sh

EXPOSE 3306

ENTRYPOINT ["./script.sh"]