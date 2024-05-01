FROM bitrixdock/php71-fpm:latest

MAINTAINER vitams

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

COPY ./php.ini /etc/php/7.1/fpm/conf.d/90-php.ini
COPY ./php.ini /etc/php/7.1/cli/conf.d/90-php.ini

RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data

EXPOSE 9000