FROM brettt89/silverstripe-web:7.1-alpine

MAINTAINER Adam Skrzypulec <adam.s@northwestern.edu>

### SET UP

RUN apt-get update

# Install PHP Extensions
RUN apt-get install -y libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_pgsql pgsql

# Apache + PHP Config
RUN echo "short_open_tag=Off" > /usr/local/etc/php/conf.d/short-open-tags.ini && \
	echo "date.timezone = America/Chicago" > /usr/local/etc/php/conf.d/timezone.ini
