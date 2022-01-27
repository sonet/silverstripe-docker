FROM ubuntu:20.04
MAINTAINER ADAM SONET "<adam@sonetseo.com>"

RUN apt-get update && apt-get install -y tzdata && rm -rf /var/lib/apt/lists/*
ENV TZ America/Chicago

RUN apt-get update && apt-get install -y \
    software-properties-common \
    apt-utils \
    curl \
		git-core

RUN add-apt-repository ppa:ondrej/php

RUN apt-get update && add-apt-repository ppa:ondrej/php && apt-get install -y \
    php8.0 \
    php8.0-fpm \
    php8.0-mbstring \
    php8.0-mysql \
    php8.0-pgsql \
    php8.0-dom \
    php8.0-gd \
    php8.0-curl \
    php8.0-tidy \
    php8.0-intl \
    php8.0-xdebug \
    nginx \
    zip \
    unzip \
    vim \
    composer \
    && rm -rf /var/lib/apt/lists/*

RUN  mkdir /var/www/project
VOLUME /var/www/project

COPY php-fpm.ini /etc/php/8.0/fpm/php.ini
COPY nginx-site /etc/nginx/sites-enabled/default
COPY xdebug.ini /etc/php/8.0/fpm/conf.d/20-xdebug.ini
COPY start.sh /root/start.sh
RUN chmod a+x /root/start.sh
RUN sed -i 's/user = www-data/user = 1000/g' /etc/php/8.0/fpm/pool.d/www.conf
CMD /root/start.sh

EXPOSE 80

# Composer
RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
&& curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
# Make sure we're installing what we think we're installing!
&& php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }" \
&& php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --snapshot \
&& rm -f /tmp/composer-setup.*
