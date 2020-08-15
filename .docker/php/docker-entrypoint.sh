#!/bin/sh

set -e

# first arg is `-f` or `--some-option`
if [ "$1" = "cron" ]; then

       if [ ! -f "/etc/cron.d/crontab" ]; then
              echo "Creating crontab file in /etc/cron.d/crontab"
              touch /etc/cron.d/crontab
              echo "Add info to crontab file:: */1 * * * * root php /var/www/html/bin/console crontasks:run > /proc/1/fd/1 2>/proc/1/fd/2"
              echo "*/1 * * * * root php /var/www/html/bin/console crontasks:run > /proc/1/fd/1 2>/proc/1/fd/2" >> /etc/cron.d/crontab
              echo "# An empty line is required at the end of this file for a valid cron file." >> /etc/cron.d/crontab
              # Prepend environment variables to the crontab
              echo "Prepend environment variables to the crontab"
              env |cat - /etc/cron.d/crontab > /tmp/crontab
              mv /tmp/crontab /etc/cron.d/crontab
       fi
fi

if [ "$1" = 'php-fpm' ] || [ "$1" = 'php bin/console' ]; then

       if [ ! -d "var/cache" ]; then
              mkdir -pv var/cache
       fi
       if [ ! -d "var/log" ]; then
              mkdir -pv var/log
       fi

       chgrp -R www-data var/cache var/log
       chmod -R g+w var/cache var/log

       if [ "$APP_ENV" != 'prod' ]; then
	       composer install --prefer-dist --no-progress --no-suggest --no-interaction
       fi
fi

exec "$@"