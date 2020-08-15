#!/usr/bin/env bash

# BEGIN ########################################################################
echo -e "-- ------------------ ---------\n"
echo -e "-- BEGIN BOOTSTRAPING DOCKER --\n"
echo -e "-- ------------------ ---------\n"

#---Import funcions script
. .docker/functions.sh


# VARIABLES ####################################################################
PWD=`pwd`
DATABASE_CONTAINER="postgres"
PHP_CONTAINER="php-fpm"
DOCKER_COMPOSE="/usr/local/bin/docker-compose"

# This function is called at the very bottom of the file
main() {
 build
}

build(){

    if [ -f ".env" ]; then
        ${DOCKER_COMPOSE} down
    fi

    ${DOCKER_COMPOSE} build
    ${DOCKER_COMPOSE} up -d

    #se ejecuta funcion que detiene el proceso hasta que el container logre conectar con la base de datos
    wait "${PHP_CONTAINER}"

    #se ejecuta el script con parametro  valor 1 para que no ejecute poblado de base de datos.
    ${DOCKER_COMPOSE} exec ${PHP_CONTAINER} bash .docker/docker-deploy.sh

}

main
# END ##########################################################################
echo -e "-- ---------------- -------"
echo -e "-- END BOOTSTRAPING BUILD--"
echo -e "-- ---------------- -------"

exit 0
