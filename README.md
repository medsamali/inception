This project has been created as part of the 42 curriculum by msamaali

Inception

Description
Inception is a 42 school project that consists of setting up a small system infrastructure entirely virtualized using Docker and Docker Compose.the goal is to configure,by hand,a set of web services(NGINX,WORDpRESS/PHP_fpm,MariaDB) that communicate with each other over a dedicated docker network
Requirements
-VM
-Docker
-make

Installation and execution
-git clone <repo_url>
cd inception
make(builds the images and starts the containers via docker compose -f srcs/docker-cpmose.yml  up --buils -d)

to stop the project:
make down

to clean 
make fclean

technical choices 

VM a full os(including the kernel,while Docckeer shares the host's kernel and only isolates the userspace ,making containers lighter and faster to start
)
Secrets vs Environment Variables
the environment variable(.env)are convenient but visible(docker inspect) while Docker secrets are mounted as temporary in_memory files inside the container and are never exposed in logs

Docker Network vs Host Network
Docker network(bridge) isolates containers from the host network and only makes them reachable from one anther(by service name),while network:host removes that ioslation and adirectry exposes the host's ports

Docker Volumes vs Bind Mounts
named volumes are manged by Docker itself(var/lib/docker/volumes)but here redirected to /home/[login/data],portable and independent from the hoost filesysysteme layout
docs
https://docs.docker.com/compose/
https://docs.docker.com/
https://wordpress.org/documentation/
https://nginx.org/en/docs/
