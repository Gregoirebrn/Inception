sleep 3

  wp config create \
    --dbname=$SQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$SQL_PASSWORD \
    --dbhost=mariadb \
    --path=/var/www/html/ \
    --allow-root

  wp core install \
    --url=$WP_URL \
    --title=$WP_TITLE \
    --admin_user=$WP_ADMIN_USER \
    --admin_email=$WP_ADMIN_EMAIL \
    --admin_password=$WP_ADMIN_PASS \
    --path=/var/www/html/ \
    --allow-root

  wp user create \
    $WP_USER \
    $WP_EMAIL \
    --user_pass=$WP_PASS \
    --path=/var/www/html/ \
    --allow-root

listen=wordpress:9000


/usr/sbin/php-fpm${PHP_VERSION} -F

echo "WordPress installation completed and users created."