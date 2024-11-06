#!/bin/bash

mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null


if [ -z "$SQL_DATABASE" ] || [ -z "$SQL_USER" ] || [ -z "$SQL_PASSWORD" ] || [ -z "$SQL_ROOT_PASSWORD" ]; then
  echo "One or more required environment variables are not set."
  echo "Please set SQL_DATABASE, SQL_USER, SQL_PASSWORD, and SQL_ROOT_PASSWORD."
  exit 1
fi

mysqld_safe --skip-networking &

until mysqladmin ping &>/dev/null; do
  echo -n "."; sleep 1
done

mysql -u root  -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"
mysql -u root  -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -u root  -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -u root -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

exec mysqld_safe