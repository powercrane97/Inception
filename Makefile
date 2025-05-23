all : up

up : 
	@docker-compose -p inception -f ./srcs/docker-compose.yml  up -d

down : 
	@docker-compose -p inception -f ./srcs/docker-compose.yml down

downr : 
	@docker-compose -p inception -f ./srcs/docker-compose.yml down --rmi all
	sudo rm -rf ~/data/mariadb/* ~/data/wordpress/*

stop : 
	@docker-compose -p inception -f ./srcs/docker-compose.yml stop

start : 
	@docker-compose -p inception -f ./srcs/docker-compose.yml start

build : 
	@docker-compose -p inception -f ./srcs/docker-compose.yml up -d --build

status : 
	@docker ps -all

logs:
	docker logs wordpress
	docker logs mariadb
	docker logs nginx

.PHONY: all up down stop start status build logs