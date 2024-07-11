FROM mariadb:latest

COPY ./ressources_relationnelles.sql /docker-entrypoint-initdb.d/ressources_relationnelles.sql
COPY ./docker-entrypoint-initdb.sh /docker-entrypoint-initdb.d/docker-entrypoint-initdb.sh
RUN chmod 755 /docker-entrypoint-initdb.d/docker-entrypoint-initdb.sh
RUN chmod 644 /docker-entrypoint-initdb.d/ressources_relationnelles.sql

RUN chown -R mysql:mysql /var/lib/mysql
