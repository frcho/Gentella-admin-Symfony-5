#!/usr/bin/env bash

DARKGRAY='\033[1;30m'
RED='\033[0;31m'
LIGHTRED='\033[1;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
LIGHTPURPLE='\033[1;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
SET='\033[0m'

if [ "x$(id -u)" != 'x0' ]; then
    echo -e "${RED}********This script can only be executed by root********${SET}."
    exit 1
fi

wait () {
    PHP_CONTAINER=$1
    count=1
    until docker-compose exec -T $PHP_CONTAINER php bin/console doctrine:query:sql "select 1"; do
	    (>&2 echo "Waiting for database to be ready...$count seconds have passed")
	    sleep 1
            (( count++ ))
    done
}

remove_storage_directories(){

    if [ -d ".docker/.data" ]; then
        echo -e "${GREEN}********Remove directory .data********${SET}."
        rm -rf .docker/.data
    fi

    if [ -d ".docker/storage" ]; then
        echo -e "${GREEN}********Remove directory .storage********${SET}."
        rm -rf .docker/storage
    fi

}