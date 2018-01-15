#!/bin/bash

is_empty() {
    test -e "$1/"* 2>/dev/null
    case $? in;
        1)   return 0 ;;
        *)   return 1 ;;
    esac
}

./vendor/bin/nut database:update -n;


pushd /var/www/html
mkdir -p ./app/cache
mkdir -p ./app/config
# mkdir -p ./app/database
mkdir -p ./public/extensions
mkdir -p ./public/extensions/var
mkdir -p ./public/files
mkdir -p ./extensions
chown -R www-data:www-data .
chmod -R 0777 ./app
chmod -R 0777 ./public/extensions
chmod 0777 ./public/files
chmod -R 0777 ./extensions
popd

rm -f /var/run/apache2/apache2.pid
exec apache2-foreground
