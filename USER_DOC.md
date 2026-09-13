

services provided
this infrastructure provides a full,secured Wordpress site,made up of three services

NGINX->secure(https) entry point for the site
wordPress->the website
MariaDB->the database storing the site's content

2- starting and stopping the project
make
#check the status of the services
docker compose -f drcd/docker-compose.yml ps
#stop the services
make down
#remove everything
make fclean

3.accessing the site and the admin panel
public site:https://msamaali.42.fr(http must not work)
WordPress admin panel:https://msamaali.42.fr/wp-admin

4-managing credentials
credentials(wordpress user,database)are stored locally 
file(/.env):contains  non-sensitive variables(domain name, database name,wordPress)
folder(secrets):contains mpd(db_mdp.txt,db_mdp,db_root_pass,credentials)

5-cheching that everything is working correctly
#check that the 3 containers are running
 docker compose -f srcs/docker-compose.yml ps
#check that the Docker network exists
 docker network ls
#check that the volumes exist and point 
 docker volume ls
Verify that HTTPS works and that HTTP is rejected:

bash

hould show a successful TLS 1.2/1.3 negotiation
curl -k https://localhost:443 -H "Host: msamaali.42.fr" -v 2>&1 | grep -i "ssl\|tls"

--should fail to connect (port 80 is not exposed)
curl http://localhost:80 -H "Host: msamaali.42.fr" -v
