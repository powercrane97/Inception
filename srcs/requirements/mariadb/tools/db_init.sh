#!/bin/bash

# launching mysqld in background
service mysql start;

# logging into MariaDB to check if database already exists; if not create one.
if mysql -u "${SQL_USER}" -p"${SQL_PASSWORD}" -e "use ${SQL_DATABASE};" &>/dev/null; then
    echo "The database '${SQL_DATABASE}' exists."
else
    echo "Initializing the database."
	echo "CREATE DATABASE $SQL_DATABASE;" > init.sql
	echo "CREATE USER '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';" >> init.sql
	echo "GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO '$SQL_USER'@'%';" >> init.sql
	echo "FLUSH PRIVILEGES;" >> init.sql
	mysql < init.sql && rm init.sql
	mysqladmin -u root password $SQL_ROOT_PASSWORD
	echo "Database is initialized."
fi
	
# shutting down mysql service
sleep 1
mysqladmin -uroot --password=$SQL_ROOT_PASSWORD shutdown
	
# launching mysql in foreground with pid=1
exec mysqld