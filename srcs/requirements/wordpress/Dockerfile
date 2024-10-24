
FROM debian:bullseye

RUN apt-get update && apt-get upgrade && apt install -y wget \
    && apt-get -y install -y php7.3 \
    php-fpm \
    php-mysql \
    mariadb-client

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/wp.conf /etc/php/8.2/fpm/pool.d/

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN chown -R root:root /var/www/wordpress

COPY ./tools/wp-script.sh /usr/local/bin/

EXPOSE 9000

ENTRYPOINT ["usr/local/bin/wp-script.sh"]

CMD ["php-fpm8.2", "-F"]