--  '$MARIADB_USER'@'%' le @'% permet de specifier que le user peut se connecter de n'importe quel host
-- FLUSH PRIVILEGES; reload pour bien effectuer les modif

CREATE DATABASE $MARIADB_DATABASE;
CREATE USER '$MARIADB_USER'@'%' IDENTIFIED by '$MARIADB_USER_PASSWORD';
GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO $MARIADB_USER@'%';

FLUSH PRIVILEGES;