#!/bin/bash

if [ -d "/var/lib/mysql/mysql" ]; then
  echo "Data directory already exists, skipping initialization."
else
  echo "Data directory not found, initializing database."
  mysql -u root -p"$MYSQL_ROOT_PASSWORD" < /docker-entrypoint-initdb.d/ressources_relationnelles.sql
fi
