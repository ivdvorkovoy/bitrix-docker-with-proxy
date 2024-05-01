#!/usr/bin/env sh
set -e -u

# This script sets proper owner and group for files in the repo

# cron tasks should be owned by root, otherwise they won't run
# and will be silently ignored
echo "Fixing cron permissions..."
chown -R 0:0 ./config/cron
chmod 0644 ./config/cron/*

# logrotate configuration should be owned by root,
# otherwise it will be ignored
echo "Fixing logrotate permissions..."
chown -R 0:0 ./config/logrotate
chmod 0644 ./config/logrotate/*

# mysql container files
echo "Fixing mysql permissions..."
chmod -R 0644 ./config/db
chown -R 1001:1001 ./config/db
[ -d ./logs/mysql ] && chown -R 1001:1001 ./logs/mysql
[ -d ./private/mysql-data ] && chmod -R 777 ./private/mysql-data
[ -d ./private/mysql-data ] && chown -R 1001:1001 ./private/mysql-data
[ -d ./private/mysqld ] && chown -R 1001:1001 ./private/mysqld

# php and nginx containers files
echo "Fixing php and nginx permissions..."
[ -d ./logs/nginx ] && chown -R 1000:1000 ./logs/nginx
[ -d ./logs/php ] && chown -R 1000:1000 ./logs/php
[ -f ./config/php/msmtprc ] && chown 1000:1000 ./config/php/msmtprc
echo "web folder will be processed now, hold on..."
chown -R 1000:1000 ./web
chmod -R 0770 ./web

echo "Fixing backup folder permissions..."
[ -d ./backup/ ] && chown -R 1000:1000 ./backup/

echo "Access rights fix is complete"
