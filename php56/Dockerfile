FROM brettt89/silverstripe-web:5.6-alpine

MAINTAINER Adam Skrzypulec <adam.s@northwestern.edu

### SET UP

RUN apt-get update

# Install PHP Extensions
RUN apt-get install -y libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_pgsql pgsql
