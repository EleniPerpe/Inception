FROM debian:latest

RUN apt update && apt upgrade -y && apt install -y \
	nginx \
	tini

COPY default /etc/nginx/sites-available/.

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["nginx", "-g", "daemon off;"]