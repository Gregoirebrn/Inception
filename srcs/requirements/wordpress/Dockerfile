FROM debian:11

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends\
    wordpress\
    curl\
    php-fpm\
    php-mysql\
    php-cli

# : Vous changez la propriété de tous les fichiers et répertoires sous /var/www/
#pour qu'ils appartiennent à l'utilisateur www-data et au groupe www-data.
RUN mkdir -p /run/php/
RUN chown -R www-data:www-data /run/php/

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/wordpress.sh .
RUN chmod +x wordpress.sh

EXPOSE 9000

ENTRYPOINT ["./wordpress.sh"]
CMD ["php-fpm7.4", "-F"]

