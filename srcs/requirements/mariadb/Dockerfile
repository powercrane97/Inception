FROM debian:buster

# install MariaDB
RUN apt-get update -y && apt-get install -y mariadb-server


# copy the database configuration file
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# create directories and configure permissions
RUN mkdir -p /var/run/mysqld
RUN mkdir -p /var/lib/mysql
RUN chown -R mysql:mysql /var/run/mysqld/
RUN chmod -R 755 /var/run/mysqld/
RUN chown -R mysql:mysql /var/lib/mysql/
RUN chmod -R 755 /var/lib/mysql/

EXPOSE 3306

COPY ./tools/db_init.sh ./
RUN chmod +x ./db_init.sh

ENTRYPOINT ["bash", "db_init.sh"]