FROM debian:bullseye

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install mariadb-server -y

RUN chown -R mysql:mysql /var/lib/mysql
RUN mkdir -p /var/run/mysqld
RUN mkfifo /var/run/mysqld/mysqld.sock
RUN chown -R mysql:mysql /var/run/mysqld

COPY ./config/mariadb.cnf /etc/mysql
COPY ./config/config.sql ./
COPY ./config/config.sh ./

ENTRYPOINT [ "bash" , "config.sh" ]
