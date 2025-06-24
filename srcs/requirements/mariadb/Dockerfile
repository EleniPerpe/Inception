FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y \
	mariadb-server \
	curl \
	&& rm -rf /var/lib/apt/lists/*
	
RUN sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/script.sh .

RUN chmod +x /script.sh

EXPOSE 3306

CMD ["/script.sh"]