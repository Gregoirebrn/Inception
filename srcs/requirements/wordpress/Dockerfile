FROM debian:bullseye

RUN apt update && apt upgrade -y \
    && apt-get install -y wget curl php7.4 php-fpm php-mysqli mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# : Vous changez la propriété de tous les fichiers et répertoires sous /var/www/
#pour qu'ils appartiennent à l'utilisateur www-data et au groupe www-data.
RUN mkdir -p /run/php/ /var/www/html \
    && chown -R www-data:www-data /var/www/*

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d
COPY ./tools/wordpress.sh .
RUN chmod +x wordpress.sh

ENTRYPOINT ["./wordpress.sh"]

CMD ["/usr/sbin/php-fpm7.4", "-F"]

EXPOSE 9000