FROM debian:bullseye

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install nginx openssl -y

COPY ./conf/nginx.conf /etc/nginx/sites-enabled/default.conf

# Generates a self-signed SSL/TLS certificate and private key using OpenSSL
RUN openssl req -x509 -nodes \
    -out /etc/ssl/tverdood.42.fr.crt \
    -keyout /etc/ssl/tverdood.42.fr.key \
    -subj "/C=BE/ST=Belgium/L=Brussels/O=42/OU=19/CN=tverdood.42.fr/UID=tverdood"

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
