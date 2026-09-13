#!/bin/bash

set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chmod 777 /run/mysqld

SQL_ROOT_PASSWORD=$(cat /run/secrets/SQL_ROOT_PASSWORD)
SQL_PASSWORD=$(cat /run/secrets/SQL_PASSWORD)

if [ ! -d "/var/lib/mysql/${SQL_DATABASE}" ]; then
    
    # Démarrage temporaire de MariaDB
    service mariadb start

    # Attente que MariaDB soit prêt
    until mysqladmin ping --silent; do
          sleep 1
    done

    # Configuration de la base et des utilisateurs
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
    mysql -u root -p${SQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

    mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown
fi

echo "Mariadb is initialised"

exec mysqld --port="${DB_PORT:-3306}"
