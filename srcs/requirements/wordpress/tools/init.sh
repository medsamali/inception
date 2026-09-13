#!/bin/bash

ADMIN_PASSWORD=$(cat /run/secrets/ADMIN_PASSWORD)
SQL_PASSWORD=$(cat /run/secrets/SQL_PASSWORD)
USER_PASSWORD=$(cat /run/secrets/USER_PASSWORD)
sleep 5

cd /var/www/html
chmod 777  /var/www/html 
mkdir -p /run/php
if [ ! -f /var/www/html/wp-config.php ]; then 
	echo "Downloading  WP"
	wp core download --allow-root --path='/var/www/html'
	echo "Configuration of WP"
	wp config create \
		--dbname=${SQL_DATABASE} \
		--dbuser=${SQL_USER} \
		--dbpass=${SQL_PASSWORD} \
		--dbhost=mariadb:${DB_PORT:-3306} \
		--allow-root
	echo "Wp is installing .. "
	wp core install \
		--url=${DOMAIN_NAME} \
		--title=${SITE_TITLE} \
		--admin_user=${ADMIN_USER} \
		--admin_password=${ADMIN_PASSWORD} \
		--admin_email=${ADMIN_EMAIL} \
		--allow-root

	wp user create \
		${USER_NAME} ${USER_EMAIL} \
		--role=author \
		--user_pass=${USER_PASSWORD} \
		--allow-root
	wp theme install astra --activate --allow-root
fi
# 2. ICI : Mise à jour automatique du port (exécutée à CHAQUE démarrage)
wp config set DB_HOST "mariadb:${DB_PORT:-3306}" --allow-root --path=/var/www/html
exec php-fpm8.3 -F
