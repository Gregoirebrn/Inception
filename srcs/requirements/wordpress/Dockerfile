
FROM debian:11

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends\
    wordpress\
    curl\
    php-fpm\
    php-mysql\
    php-cli
RUN mkdir -p /run/php/
RUN chown -R www-data:www-data /run/php/

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/wordpress.sh .
RUN chmod +x wordpress.sh

ENTRYPOINT ["./wordpress.sh"]

CMD ["php-fpm7.4", "-F"]

