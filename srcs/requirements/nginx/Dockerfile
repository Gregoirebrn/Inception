
FROM debian:11

RUN apt-get update \
    && apt-get install -y nginx openssl \
    && mkdir -p /etc/nginx/ssl \
    && openssl req -x509 -nodes  \
    -out /etc/nginx/ssl/inception.crt  \
    -keyout /etc/nginx/ssl/inception.key  \
    -subj "/C=FR/ST=IDF/L=Lyon/0=42/OU=42/CN=grebrune.42.fr/UID=grebrune"

COPY conf/nginx.conf etc/nginx/nginx.conf
RUN mkdir -p /var/run/nginx

CMD ["nginx", "-g", "daemon off;" ]