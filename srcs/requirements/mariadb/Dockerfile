
FROM debian:bullseye

RUN apt-get update \
    && apt-get install -y mariadb-server \
    mariadb-client \
    && mkdir -p /var/run/mysql \
    && chown -R mysql:mysql /var/run/mysql

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod +x /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]

CMD ["mysqld", "--blid-address=0.0.0.0"]