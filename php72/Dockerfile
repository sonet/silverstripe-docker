	FROM php:7.2.6-apache
MAINTAINER Adam Skrzypulec "<adam.s@northwestern.edu>"
ENV DEBIAN_FRONTEND=noninteractive

# Install components
RUN apt-get update -y && apt-get install -y \
		iputils-ping \
		curl \
		wget \
		git-core \
		gzip \
		unzip \
		libcurl4-openssl-dev \
		libgd-dev \
		libldap2-dev \
		libmcrypt-dev \
		libsodium-dev \
		libtidy-dev \
		libxslt-dev \
		zlib1g-dev \
		libicu-dev \
		g++ \
		openssh-client \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libpng-dev \
		libxpm-dev \
		libvpx-dev \
	--no-install-recommends && \
	rm -r /var/lib/apt/lists/*

# install postgres-libs
RUN apt-get update -y && apt-get install -y \
		postgresql-server-dev-all

# Install PHP Extensions
RUN docker-php-ext-configure intl && \
	docker-php-ext-configure mysqli --with-mysqli=mysqlnd && \
	docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && \
	docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
	docker-php-ext-install -j$(nproc) \
		bcmath \
		intl \
		ldap \
		mysqli \
		pgsql \
		pdo \
		pdo_mysql \
		pdo_pgsql \
		soap \
		tidy \
		xsl \
		zip\
		sodium\
&& docker-php-ext-configure gd \
    --with-freetype-dir=/usr/lib/x86_64-linux-gnu/ \
    --with-jpeg-dir=/usr/lib/x86_64-linux-gnu/ \
    --with-xpm-dir=/usr/lib/x86_64-linux-gnu/ \
    --with-vpx-dir=/usr/lib/x86_64-linux-gnu/ \
&& docker-php-ext-install gd

# mcrypt
RUN	pecl install mcrypt-1.0.1 && \
	docker-php-ext-enable mcrypt

# Apache + xdebug configuration
RUN { \
                echo "<VirtualHost *:80>"; \
                echo "  DocumentRoot /var/www/html/public"; \
                echo "  LogLevel warn"; \
                echo "  ErrorLog /var/log/apache2/error.log"; \
                echo "  CustomLog /var/log/apache2/access.log combined"; \
                echo "  ServerSignature Off"; \
                echo "  <Directory /var/www/html/public>"; \
                echo "    Options +FollowSymLinks"; \
                echo "    Options -ExecCGI -Includes -Indexes"; \
                echo "    AllowOverride all"; \
                echo; \
                echo "    Require all granted"; \
                echo "  </Directory>"; \
                echo "  <LocationMatch assets/>"; \
                echo "    php_flag engine off"; \
                echo "  </LocationMatch>"; \
                echo; \
                echo "  IncludeOptional sites-available/000-default.local*"; \
                echo "</VirtualHost>"; \
	} | tee /etc/apache2/sites-available/000-default.conf

RUN echo "ServerName localhost" > /etc/apache2/conf-available/fqdn.conf && \
	echo "date.timezone = America/Chicago" > /usr/local/etc/php/conf.d/timezone.ini && \
	echo "short_open_tag=Off" > /usr/local/etc/php/conf.d/short-open-tags.ini && \
	a2enmod rewrite expires remoteip cgid && \
	usermod -u 1000 www-data && \
	usermod -G staff www-data

# Opcache
RUN docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install opcache
# Copy configuration
COPY config/opcache.ini $PHP_INI_DIR/conf.d/

# Xdebug
RUN pecl install xdebug && \
		docker-php-ext-enable xdebug && \
		sed -i '1 a xdebug.remote_autostart=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
        sed -i '1 a xdebug.remote_mode=req' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
        sed -i '1 a xdebug.remote_handler=dbgp' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
        sed -i '1 a xdebug.remote_connect_back=0' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
        sed -i '1 a xdebug.remote_port=9000' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
        sed -i '1 a xdebug.remote_host=docker.for.mac.localhost' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
        sed -i '1 a xdebug.remote_enable=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
        sed -i '1 a xdebug.remote_log=/tmp/xdebug.log' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
		sed -i '1 a xdebug.idekey=PHPSTORM' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

EXPOSE 80
CMD ["apache2-foreground"]

# Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"  && \
php -r "if (hash_file('sha384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"  && \
php composer-setup.php  && \
php -r "unlink('composer-setup.php');"
