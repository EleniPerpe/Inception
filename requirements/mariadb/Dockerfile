FROM debian:bullseye

COPY tools/script.sh .

RUN mkdir -p /docker-entrypoint-initdb.d \
    /run/mysqld \
    /etc/mysql/mariadb.conf.d && chmod +x /script.sh

RUN apt update && apt upgrade -y && apt install -y \
    mariadb-server \
    curl \
    gettext

COPY 50-server.conf /etc/mysql/mariadb.conf.d/

EXPOSE 3306

ENTRYPOINT ["./script.sh"]