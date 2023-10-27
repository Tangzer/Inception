FROM debian:bullseye

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql curl

RUN mkdir -p /run/php

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY ./config/wp-config.sh ./

WORKDIR /var/www/wordpress
RUN wp core download --allow-root
#apashe a s'est propre group et user donc on modifie le owner a ceux deja existant
RUN chown -R www-data:www-data /var/www/wordpress

ENTRYPOINT [ "bash", "/wp-config.sh" ]