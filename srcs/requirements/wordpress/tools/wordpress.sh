#!/bin/bash
sleep 5
cd /var/www/html
echo "0==========="

if [ -f "/var/www/html/wp-config.php" ]; then
    echo Wordpres deja blablabla
else
    echo "1==========="

    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    echo "2==========="
    chmod +x wp-cli.phar

    echo "3==========="
    ./wp-cli.phar core download --locale=en_GB --allow-root

    echo "4==========="
    ./wp-cli.phar config create --allow-root --dbname="$SQL_DATABASE" --dbuser="$SQL_USER" --dbpass="$SQL_PASSWORD" \
                 --dbhost=mariadb
    echo "5==========="
    ./wp-cli.phar core install --allow-root --url="https://$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" \
                --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL"

    echo "6==========="
    ./wp-cli.phar user create --allow-root "$WP_USER" "$WP_EMAIL" --user_pass="$WP_PASS" --path="$WP_PATH" --allow-root 2>/dev/null

#    chown -R wwww-data:www-data /var/www/html/wp-content/
    echo "7==========="
fi
echo "8==========="

exec "$@"