FROM brettt89/silverstripe-web:5.6-alpine

MAINTAINER Adam Skrzypulec <adam.s@northwestern.edu

### SET UP

RUN apt-get update

# Install PHP Extensions
RUN apt-get install -y libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_pgsql pgsql

#Opcache
RUN docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install opcache
# Copy configuration
COPY config/opcache.ini $PHP_INI_DIR/conf.d/

# Composer
RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
&& curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
# Make sure we're installing what we think we're installing!
&& php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }" \
&& php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --snapshot \
&& rm -f /tmp/composer-setup.*