FROM bitrixdock/php56-fpm:latest

RUN apt-get update \
    && apt-get -y --allow-downgrades --no-install-recommends install \
    php-pear php7.4-dev libmcrypt-dev gcc make autoconf libc-dev pkg-config \
    msmtp \
    msmtp-mta \
    sudo \
    cron \
    git \
    npm \
    && pecl install mcrypt-1.0.4 \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# DO NOT install php7.4-xdebug package for site running in production! It will slow it down significantly.

COPY ./php.ini /etc/php5/fpm/conf.d/90-php.ini
COPY ./php.ini /etc/php5/cli/conf.d/90-php.ini

RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data

EXPOSE 9000
