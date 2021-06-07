FROM php:7.1

RUN apt-get update \
    && apt-get -y install libgmp-dev libmcrypt-dev libssh2-1 libssh2-1-dev libsodium-dev \
    && pecl install libsodium ssh2-1.3.1 \
    && docker-php-ext-install gmp bcmath mcrypt \
    && docker-php-ext-enable ssh2 sodium
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \
    && apt-get -y install git unzip