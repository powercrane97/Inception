FROM debian:oldstable

RUN apt-get update -y && \
	apt-get install -y wget php7.4 php-fpm php-mysql

# a command-line interface for WordPress, you can manage WordPress once it's downloaded
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar  && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN apt-get update && apt-get install -y mariadb-client

# downloading wordpress package
RUN wget https://wordpress.org/wordpress-6.1.1.tar.gz -P /var/www/html

RUN cd /var/www/html && \
	tar -xzf /var/www/html/wordpress-6.1.1.tar.gz && \
	rm /var/www/html/wordpress-6.1.1.tar.gz

# ensure that the web server(nginx) has the necessary permissions to read and execute the files within the web root directory
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

EXPOSE 9000

COPY ./tools/wp_config.sh ./
RUN chmod +x ./wp_config.sh

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

ENTRYPOINT ["bash", "./wp_config.sh"]