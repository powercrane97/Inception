#!/bin/bash

# launching mysqld in background
service mariadb start;

# logging into MariaDB to check if database already exists; if not create one.
if mysql -u "${SQL_USER}" -p"${SQL_PASSWORD}" -e "use ${SQL_DATABASE};" &>/dev/null; then
    echo "The database '${SQL_DATABASE}' exists."
else
    echo "Initializing the database."
	echo "CREATE DATABASE $SQL_DATABASE;" > init.sql
	echo "CREATE USER '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';" >> init.sql
	echo "GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO '$SQL_USER'@'%';" >> init.sql
	echo "ALTER USER root@localhost IDENTIFIED VIA mysql_native_password USING PASSWORD('$SQL_ROOT_PASSWORD');" >> init.sql
	echo "FLUSH PRIVILEGES;" >> init.sql
	mysql < init.sql && rm init.sql
	echo "Database is initialized."
fi
	
# shutting down mysql service
mysqladmin -uroot --password=$SQL_ROOT_PASSWORD shutdown
	
# launching mysqld in foreground with pid=1
exec mysqld