all:
	docker-compose -f ./srcs/docker-compose.yml build
	sudo echo "127.0.0.1 tverdood.42.fr" >> /etc/hosts
	mkdir -p /home/tverdood/data/database
	mkdir -p /home/tverdood/data/wordpress
	docker-compose -f ./srcs/docker-compose.yml up --detach
	@echo "ready to use"

up:
	docker-compose -f ./srcs/docker-compose.yml up --detach
	@echo "the container is up"

down:
	docker-compose -f ./srcs/docker-compose.yml down
	@echo "the container is down"

clean: down
	docker volume rm srcs_mariadb_volume
	docker volume rm srcs_wordpress_volume
	@echo "cleaned"

fclean: clean
	@docker image rm srcs_mariadb
	@docker image rm srcs_wordpress
	@docker image rm srcs_nginx
	@docker image rm debian:buster
	@sudo rm -rf /home/tverdood/data
	@echo "fcleaned"

re: fclean all

.PHONY: all up down clean fclean re
