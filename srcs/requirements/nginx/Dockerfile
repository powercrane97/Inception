FROM debian:buster

# install NGINX and openssl
RUN apt-get update -y && \
	apt-get install -y nginx && \
	apt-get install -y openssl && \
	mkdir -p /etc/nginx/ssl

# generate the keys
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=rarnold.42.fr/UID=rarnold"

# copy the provided config file to the container and set the permissions 
RUN mkdir -p /var/run/nginx && chmod -R 755 /var/www/html && chown -R www-data:www-data /var/www/html
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

# redirect logs to stdout and stderr
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

CMD ["nginx", "-g", "daemon off;"]