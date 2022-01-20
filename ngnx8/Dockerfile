FROM ubuntu:20.04
MAINTAINER ADAM SONET "<adam@sonetseo.com>"

RUN apt-get update && apt-get install -y tzdata && rm -rf /var/lib/apt/lists/*
ENV TZ America/Chicago

RUN apt-get update && apt-get install -y \
    software-properties-common \
    apt-utils

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
CMD /root/start.sh

EXPOSE 80
