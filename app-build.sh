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

# Se pregunta si desea ejectuar el script, e informa que al hacerlo borrara la base de datos
echo " "
echo " "
echo "Really, You want to run this script, It deletes the database in container $DATABASE_CONTAINER if exist (y/n)?"
read TYPE_ANSWER

# This function is called at the very bottom of the file
main() {
 build
}

build(){

    if [ -f ".env" ]; then
        ${DOCKER_COMPOSE} down --remove-orphans
    fi

    ${DOCKER_COMPOSE} build
    ${DOCKER_COMPOSE} up -d

    #se ejecuta funcion que detiene el proceso hasta que el container logre conectar con la base de datos
    wait "${PHP_CONTAINER}"

    ${DOCKER_COMPOSE} exec ${PHP_CONTAINER} bash .docker/docker-deploy.sh

}

if [ "$TYPE_ANSWER" != "${TYPE_ANSWER#[Yy]}" ] ;then

    echo -e "${GREEN}********Remove store directories********${SET}."

    #se ejecuta funcion que elimina los directorios de almacenamiento si estos existen
        remove_storage_directories

    echo -e "${GREEN}********Executing main script********${SET}."

        main
    echo -e "${GREEN}********Executed main script********${SET}."
else
    echo -e "${BLUE}********Script won't be run********${SET}."
fi

# END ##########################################################################
echo -e "-- ---------------- -------"
echo -e "-- END BOOTSTRAPING BUILD--"
echo -e "-- ---------------- -------"

exit 0