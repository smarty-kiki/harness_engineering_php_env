#!/bin/bash

# PHP FPM Configuration
sed -i 's/;listen.mode = 0660/listen.mode = 0666/' /etc/php/8.4/fpm/pool.d/www.conf
sed -i 's/listen = \/run\/php\/php8.4-fpm.sock/listen = \/var\/run\/php-fpm.sock/' /etc/php/8.4/fpm/pool.d/www.conf

# MongoDB Configuration
mkdir -p /var/log/mongodb /var/lib/mongodb
chown -R mongodb:mongodb /var/log/mongodb /var/lib/mongodb

# Redis Configuration
mkdir -p /var/log/redis /var/lib/redis
chown -R redis:redis /var/log/redis /var/lib/redis

# Beanstalkd Configuration
mkdir -p /var/lib/beanstalkd /var/log/beanstalkd

# Nginx Configuration
sed -i 's/user www-data/user root/' /etc/nginx/nginx.conf

# Create necessary directories
mkdir -p /var/www
mkdir -p /tmp/php_exception.log /tmp/php_notice.log /tmp/php_module.log
chmod 777 /tmp/php_exception.log /tmp/php_notice.log /tmp/php_module.log

# MySQL Configuration
chown -R mysql:mysql /var/lib/mysql /var/log/mysql

# PHP Error Log
touch /var/log/php-fpm.log
chmod 666 /var/log/php-fpm.log

# Disable xhgui tideways extension (not available for PHP 8.4 yet)
