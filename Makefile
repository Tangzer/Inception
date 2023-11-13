all:
	sudo docker-compose -f ./srcs/docker-compose.yml build
	sudo sh -c 'echo "127.0.0.1 tverdood.42.fr" >> /etc/hosts'
	mkdir -p /home/tverdood/data/database
	mkdir -p /home/tverdood/data/wordpress
	sudo docker-compose -f ./srcs/docker-compose.yml up --detach
	@echo "ready to use"

up:
	sudo docker-compose -f ./srcs/docker-compose.yml up --detach
	@echo "the container is up"

down:
	sudo docker-compose -f ./srcs/docker-compose.yml down
	@echo "the container is down"

clean: down
	sudo docker volume rm srcs_mariadb_volume
	sudo docker volume rm srcs_wordpress_volume
	@echo "cleaned"

fclean: clean
	@sudo docker image rm srcs_mariadb
	@sudo docker image rm srcs_wordpress
	@sudo docker image rm srcs_nginx
	@sudo docker image rm debian:buster
	@sudo rm -rf /home/tverdood/data
	@echo "fcleaned"

re: fclean all

.PHONY: all up down clean fclean re
