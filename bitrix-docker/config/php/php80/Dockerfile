FROM phpdockerio/php:8.0-fpm

RUN apt-get update \
    && apt-get -y --no-install-recommends install \
    php8.0-memcached \
    php8.0-memcache \
    php8.0-mbstring \
    php8.0-mysql \
    php8.0-intl \
    php8.0-interbase \
    php8.0-soap \
    php8.0-gd \
    php8.0-imagick \
    php8.0-opcache \
    php8.0-zip \
    php-pear php8.0-dev libmcrypt-dev gcc make autoconf libc-dev pkg-config \
    msmtp \
    msmtp-mta \
    sudo \
    cron \
    git \
    npm \
    && pecl install mcrypt-1.0.4 \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

COPY ./php.ini /etc/php/8.0/fpm/conf.d/90-php.ini
COPY ./php.ini /etc/php/8.0/cli/conf.d/90-php.ini

RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data

EXPOSE 9000
