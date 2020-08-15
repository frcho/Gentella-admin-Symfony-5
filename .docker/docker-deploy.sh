#!/usr/bin/env bash

# BEGIN ########################################################################
echo -e "-- ------------------ --\n"
echo -e "-- BEGIN BOOTSTRAPING --\n"
echo -e "-- ------------------ --\n"

# VARIABLES ####################################################################
CREATE_DATABASE=$1

# This function is called at the very bottom of the file
main() {
  setting
  owner_directories
}

owner_directories(){
    chown -R www-data.www-data var/cache var/log public/uploads
}

setting(){
    composer install --prefer-dist --no-progress --no-suggest --no-interaction

    if [ ! -d "public/uploads/" ]; then
         mkdir -p public/uploads/
    fi


    if [ ! -d "var/cache/" ]; then
         mkdir -p var/cache/
    fi

    if [ ! -d "var/log/" ]; then
         mkdir -p var/log/
    fi

    rm -rf var/cache/* var/log/*

    # php bin/console d:s:u --force
    # php bin/console assets:install public
    # php bin/console d:f:l --append
    #https://symfony.com/doc/current/frontend/encore/installation.html
    #https://symfony.com/doc/current/frontend/encore/simple-example.html
#     yarn install
#     yarn encore dev

    #validar compilacion de encore para prod
    # yarn encore production

    chmod -R 777 var var/cache var/log
}

#exec >> /tmp/deploy.log
main
# END ##########################################################################
echo -e "-- ---------------- --------"
echo -e "-- END BOOTSTRAPING DEPLOY--"
echo -e "-- ---------------- --------"

exit 0
