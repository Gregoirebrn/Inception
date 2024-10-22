
FROM debian:bullseye

RUN apt update \
    && apt install -y nginx openssl \
    && mkdir -p /etc/nginx/ssl \
    && openssl req -x509 -nodes  \
    -out /etc/nginx/ssl/inception.crt  \
    -keyout /etc/nginx/ssl/inception.key  \
    -subj "/C=FR/ST=IDF/L=Lyon/0=42/OU=42/CN=grebrune.42.fr/UID=grebrune" \
    && chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/run/nginx

COPY conf/nginx.conf etc/nginx/nginx.conf

CMD [ "nginx", "-g", "daemon off;" ]