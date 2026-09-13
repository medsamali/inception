FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        wget \
    \
    && curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg \
        https://packages.sury.org/php/apt.gpg \
    \
    && echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ bookworm main" \
        > /etc/apt/sources.list.d/php.list \
    \
    && apt-get update \
    \
    && apt-get install -y --no-install-recommends \
        php8.3 \
        php8.3-cli \
        php8.3-bz2 \
        php8.3-curl \
        php8.3-mbstring \
        php8.3-intl \
        php8.3-fpm \
		php8.3-mysql \
		mariadb-client \
    \
    # Clean up
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget  https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp



RUN sed -i 's/listen = \/run\/php\/php8.3fpm.sock/listen = 9000/g' /etc/php/8.3/fpm/pool.d/www.conf

RUN mkdir -p /run/php

COPY tools/init.sh /usr/local/bin/init.sh

RUN chmod +x /usr/local/bin/init.sh

WORKDIR /var/www/html

EXPOSE 9000

RUN chown -R www-data:www-data /var/www/html

ENTRYPOINT ["/usr/local/bin/init.sh"]
