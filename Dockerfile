FROM php:8.2

RUN apt-get update \
    && apt-get -y install libgmp-dev libmcrypt-dev libssh2-1 libssh2-1-dev \
    && pecl install mcrypt ssh2-1.3.1 \
    && docker-php-ext-install gmp bcmath opcache \
    && docker-php-ext-enable ssh2 \
    && printf "extension=mcrypt.so" > /usr/local/lib/php.ini
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \
    && apt-get -y install git unzip

COPY opcache.ini /usr/local/etc/php/conf.d/opcache.ini
