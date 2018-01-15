FROM        php:7.1-apache
MAINTAINER  Karlheinz Späth "karlheinz.spaeth@gmail.com"

RUN apt-get update && apt-get install -y \
         libpq-dev \
         git \
         libpng-dev \
         libjpeg62-turbo-dev \
         libfreetype6-dev \
         wget \
         libxrender1 \
         libfontconfig1 \
         libicu-dev \
         g++ \
         locales

RUN    echo "en_GB.UTF-8 UTF-8" > /etc/locale.gen \
    && echo "de_DE.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
         && docker-php-ext-install -j$(nproc) gd \
         && docker-php-ext-install pdo_mysql \
         && docker-php-ext-install exif \
         && docker-php-ext-install zip \
         && docker-php-ext-install intl \
         && docker-php-ext-configure intl

#        && apt-get clean \
#        && rm -rf /var/lib/apt/lists/*

RUN a2enmod headers
RUN a2enmod rewrite

# Copy across the local files to the root directory
ADD html /var/www/html/
ADD ./server/php-config.ini /usr/local/etc/php/conf.d/php-config.ini
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN cd /var/www/html && composer install
RUN cp -r ./vendor/bolt/themes/ ./public/theme/
RUN chown -R www-data:www-data /var/www/html

ADD ./server/apache-vhost.conf /etc/apache2/sites-available/001-bolt.conf
RUN    a2dissite 000-default \
    && a2ensite  001-bolt

ADD start-bolt.sh /usr/bin
RUN chmod +x /usr/bin/start-bolt.sh


CMD ["start-bolt.sh"]
