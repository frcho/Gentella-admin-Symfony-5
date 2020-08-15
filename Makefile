# base on https://github.com/LINKIT-Group/dockerbuild/blob/master/Makefile
# base on https://itnext.io/docker-makefile-x-ops-sharing-infra-as-code-parts-ea6fa0d22946
# Needed SHELL since I'm using zsh
SHELL := /bin/bash
# --------------------------------------------------------------------
# Copyright (c) 2019 LINKIT, The Netherlands. All Rights Reserved.
# Author(s): Anthony Potappel
#
# This software may be modified and distributed under the terms of the
# MIT license. See the LICENSE file for details.
# --------------------------------------------------------------------

# If you see pwd_unknown showing up, this is why. Re-calibrate your system.
PWD ?= pwd_unknown

# Note. If you change this, you also need to update docker-compose.yml.
# only useful in a setting with multiple services/ makefiles.
SERVICE_TARGET := php-fpm

# if vars not set specifially: try default to environment, else fixed value.
# strip to ensure spaces are removed in future editorial mistakes.
# tested to work consistently on popular Linux flavors and Mac.
ifeq ($(user),)
# USER retrieved from env, UID from shell.
HOST_USER ?= $(strip $(if $(USER),$(USER),nodummy))
HOST_UID ?= $(strip $(if $(shell id -u),$(shell id -u),4000))
endif

THIS_FILE := $(lastword $(MAKEFILE_LIST))

# export such that its passed to shell functions for Docker to pick up.
export HOST_USER
export HOST_UID

.PHONY: shell help ps log stop down clean
# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'

help: ## -------------------Help---------------------
	@echo -e ''
	@echo -e 'Usage: make [TARGET] [EXTRA_ARGUMENTS]'
	@echo -e 'Targets:'
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

help-online: #-- -------------------Help---------------------
	    @echo -e "$$(grep -hE '^\S+:.*#--' $(MAKEFILE_LIST) | sed -e 's/:.*#--\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

#It's good practice to use absolute paths in this file, because It will used with crontabs and your $PATH may not be the same as an interactive shell. 

# shell is the first target. So instead of: make shell cmd="whoami", we can type: make cmd="whoami".
# more examples: make shell cmd="whoami && env", make shell cmd="echo hello container space".
# leave the double quotes to prevent commands overflowing in makefile (things like && would break)
# special chars: '',"",|,&&,||,*,^,[], should all work. Except "$" and "`", if someone knows how, please let me know!).
# escaping (\) does work on most chars, except double quotes (if someone knows how, please let me know)
# i.e. works on most cases. For everything else perhaps more useful to upload a script and execute that.
shell:
	docker-compose exec $(SERVICE_TARGET) bash

dev:   ## Build app in local environment, This option request for remove database even if it does not exist.
	./app-build.sh

run:   ## Deploy app in local environment, Run this if you already executed make dev.
	./app-deploy.sh

ps:   ## Run if you want to see status of containers
	/usr/local/bin/docker-compose ps

logs:   ## Run if you want to see logs of containers
	/usr/local/bin/docker-compose logs -f

down:
	/usr/local/bin/docker-compose down

stop:  ## Run if you want to stop containers
	/usr/local/bin/docker-compose stop

clean:
	/usr/local/bin/docker images -qf dangling=true | xargs -r --no-run-if-empty docker rmi