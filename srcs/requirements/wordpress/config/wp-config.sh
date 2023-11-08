#!/bin/sh

# > /dev/null 2>&1 renvoi touts les msg d'erreur a dev/null qui mute tout 
grep -E "listen = 9000" "/etc/php/7.4/fpm/pool.d/www.conf" > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "modifying listen port"
	sed -i "s|.*listen = /run/php/php7.4-fpm.sock.*|listen = 9000|g" "/etc/php/7.4/fpm/pool.d/www.conf"
fi

#--skip check permet de creer le wp-config.php sans checker la database
rm -rf /var/www/htmlwordpress/wp-config.php
wp config create	--dbname=$MARIADB_DATABASE \
					--dbuser=$MARIADB_USER \
					--dbpass=$MARIADB_USER_PASSWORD \
					--dbhost=$MARIADB_HOST \
					--path="/var/www/wordpress/" \
					--skip-check \
					--allow-root

#--skip email permet de ne pas envoyer de mail avec les informartion de login a l'admin
if ! wp core is-installed --allow-root; then
	echo "installing wordpress"
	wp core install --url=$WORDPRESS_URL \
					--title=$WORDPRESS_TITLE \
					--admin_user=$WORDPRESS_ADMIN \
					--admin_password=$WORDPRESS_ADMIN_PASSWORD \
					--admin_email=$WORDPRESS_ADMIN_EMAIL \
					--skip-email \
					--allow-root

	echo "update wordpress"
	wp plugin update --all --allow-root
	
	echo "create Wordpress user"
	wp user create $WORDPRESS_USER \
					$WORDPRESS_USER_EMAIL \
					--role=editor\
					--user_pass=$WORDPRESS_USER_PASSWORD \
					--allow-root
	
	echo "generate first post"
	wp post generate --count=1 \
						--post_title=$WORDPRESS_TITLE \
						--post_author=$WORDPRESS_ADMIN \
						--post_content="first post for the example" \
						--allow-root
fi

echo "starting wordpress"
php-fpm7.3 --nodaemonize
