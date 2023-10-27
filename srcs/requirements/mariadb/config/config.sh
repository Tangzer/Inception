#!/bin/sh

if [ ! -d /var/lib/mysql/$MARIADB_DATABASE ]; then
    service mysql start --datadir=/var/lib/mysql

    echo "creation of database : $MARIADB_DATABASE"
    eval "echo \"$(cat config.sql)\"" | mariadb -u root
    mysqladmin -u root password $MARIADB_ROOT_PASSWORD

    service mysql stop --datadir=/var/lib/mysql
fi

# mysqld_safe lance mania db de maniere safe en permettant par exemple de relancer le service en cas d'erreur

echo "$MARAIDB_DATABASE is ready to be used"
mysqld_safe --datadir=/var/lib/mysql