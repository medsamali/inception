NAME = inception

all:
	@echo "Demarrage .."
	mkdir -p ~/data/wordpress
	mkdir -p ~/data/mariadb
	docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@echo "Arret"
	docker compose -f ./srcs/docker-compose.yml down

logs:
	docker compose -f ./srcs/docker-compose.yml logs

clean: down
	@echo "Nettoyage des conteneurs inutilises"
	docker system prune -f

fclean:
	@echo "Nettoyage complet"
	docker compose -f ./srcs/docker-compose.yml down -v --rmi all
	docker system prune -af --volumes
	sudo rm -rf ~/data

re: fclean all

.PHONY: all down clean fclean re
