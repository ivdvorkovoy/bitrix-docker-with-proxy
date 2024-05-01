FROM phpdockerio/php73-fpm:latest

RUN apt-get update \
    && apt-get -y --allow-downgrades --no-install-recommends install \
    php7.2-memcached \
    php7.2-memcache \
    php7.2-mbstring \
    php7.2-mysql \
    php7.2-intl \
    php7.2-interbase \
    php7.2-soap \
    php7.2-gd \
    php7.2-imagick \
    php7.2-ldap \
    php7.2-opcache \
    php7.2-zip \
    php-pear php-dev libmcrypt-dev gcc make autoconf libc-dev pkg-config \
    msmtp \
    msmtp-mta \
    sudo \
    cron \
    git \
    npm \
    && pecl install mcrypt-1.0.3 \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

COPY ./php.ini /etc/php/7.2/fpm/conf.d/90-php.ini
COPY ./php.ini /etc/php/7.2/cli/conf.d/90-php.ini

RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data

EXPOSE 9000
