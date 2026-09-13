FROM debian:bookworm

RUN apt-get update && apt-get install -y --no-install-recommends openssl nginx && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl


RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/0=42/OU=42/CN=msamaali.42.fr/UID=msamaali"


COPY conf/nginx.conf /etc/nginx/conf.d/default.conf



CMD ["nginx", "-g", "daemon off;"]
