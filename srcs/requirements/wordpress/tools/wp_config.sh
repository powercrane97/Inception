#!/bin/bash

if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
	
	cd /var/www/html/wordpress

	wp config create --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD --dbhost=$SQL_HOST --allow-root
	wp core install --allow-root \
					--url=${DOMAIN_NAME} \
					--title=$SITE_TITLE \
					--admin_user=$WP_ADMIN \
					--admin_password=$WP_ADMIN_PASSWORD \
					--admin_email=$WP_ADMIN_EMAIL \
					--skip-email 

	wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASS --allow-root

	chown -R www-data:www-data /var/www/html/;
	chmod -R 755 /var/www/html/;

fi

#create a directory for php
if [ ! -d /run/php ]; then
	mkdir /run/php;
fi

exec /usr/sbin/php-fpm7.4 -F -R