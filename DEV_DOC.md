
Developer Documentation

describes how to set up ,maintain this project from a technical standpoint
1-Prerequisites

you must :
-docker
-make
-commande linux 
2.0 Setting up the environment from scratch

2.1-clone the repository
git clone <url_repo>inception
 1.1 create the secrets files
    - db_password, db_root_pass,credentials
 1.2 create file {.env}
    for example
    MYSQL_NAME = msamaali.42.fr
    WP_USER=[]
 1.3 add local doamine 
    4- echo "127.0.0.1[LOGIN].42.fr" | sudo tee -a /etc/hosts
 1.4 create repos
    worldpress,mariadb
2- building and launching via makefile
    make
    make clean
    make fclean
    make re
    make down
-> make call docker compose -f srcs/docker-compose.yml up --build -d

example of commande for test
# rebuild a single service after change
docker compose -f srcs/docker-compose.yml up --build -d maridb ou wordpress
#list the project's containers
docker compose -f srcs/docker-compose.yml ps

docker compose -f srcs/docker-compose.yml logs -f 
list volume
docker volume ls

docker exec -it maridb mysql -u root -p
.
├── Makefilw
├── secrets/
└── srcs/
    ├── docker-compose.yml
    ├── .env
    └── requirements/
        ├── nginx/
        │   ├── Dockerfile
        │   └── conf/
        ├── wordpress/
        │   ├── Dockerfile
        │   └── conf/
        ├── mariadb/
        │   ├── Dockerfile
        │   └── conf/
