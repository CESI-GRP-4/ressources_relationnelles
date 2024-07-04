FROM mariadb:latest
COPY ./ressources_relationnelles.sql /docker-entrypoint-initdb.d/ressources_relationnelles.sql
RUN chmod 644 /docker-entrypoint-initdb.d/ressources_relationnelles.sql
