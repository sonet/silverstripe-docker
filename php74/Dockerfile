	FROM php:7.4.15-apache
MAINTAINER Adam Skrzypulec "<adam.s@northwestern.edu>"
ENV DEBIAN_FRONTEND=noninteractive

# Install components
RUN apt-get update -y && apt-get install -y --no-install-recommends \
  		iputils-ping \
		curl \
		less \
		git-core \
		gzip \
		unzip \
		libcurl4-openssl-dev \
		libgd-dev \
		libzip-dev \
		libldap2-dev \
#		libsodium-dev \
		libtidy-dev \
		libxslt-dev \
		zlib1g-dev \
		libicu-dev \
		g++ \
		vim \
		openssh-client \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libpng-dev \
		libxpm-dev \
		apt-utils \
  		# needed for gd
  		libfreetype6-dev \
  		libjpeg62-turbo-dev \
  		libpng-dev \
		&& rm -r /var/lib/apt/lists/*

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
#		sodium\
&& docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    --with-xpm \
&& docker-php-ext-install gd

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
	echo "memory_limit = 512M" > /usr/local/etc/php/conf.d/memory-limit.ini && \
	echo "max_execution_time = 300" > /usr/local/etc/php/conf.d/execution-limit.ini && \
	echo "short_open_tag = Off" > /usr/local/etc/php/conf.d/short-open-tags.ini && \
	echo "log_errors = On" > /usr/local/etc/php/conf.d/log-errors.ini && \
	echo "error_log = /dev/stderr" > /usr/local/etc/php/conf.d/log-errors.ini && \
	a2enmod rewrite expires remoteip cgid && \
	usermod -u 1000 www-data && \
	usermod -G staff www-data

EXPOSE 80
CMD ["apache2-foreground"]

# Composer
RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
&& curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
# Make sure we're installing what we think we're installing!
&& php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }" \
&& php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --snapshot \
&& rm -f /tmp/composer-setup.*
