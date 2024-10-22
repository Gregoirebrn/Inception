
FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt-get install mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mysql -e
service mysql start;
    mysql -e "CREATE DATABASE IF NOT EXISTS \'${SQL_DATABASE}\';"
    mysql -e "CREATE USER IF NOT EXISTS \'${SQL_USER}\'@'grebrune.42.fr' IDENTIFIED BY '${SQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \'${SQL_DATABASE}\'.* TO \'${SQL_USER}\ '@'%' IDENTIFIED BY '${SQL_PASSWORD}';" \
    mysql -e "ALTER USER 'root'@'grebrune42.fr' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"