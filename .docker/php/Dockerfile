ARG VERSION=20.04

FROM ubuntu:${VERSION} AS dev

LABEL MAINTAINER frcho <luisfer1g@gmail.com>

ARG TIMEZONE=America/Bogota
ARG PHP_VERSION=7.3


RUN \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ondrej/php; \
    apt-get update && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends --no-install-suggests apt-utils \
    ca-certificates gettext \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-bcmath \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-imap \
    php${PHP_VERSION}-intl \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-memcached \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-imagick \
    curl \
    wget \
    unzip \
    vim \
    htop \
    git \
    cron \
    && mkdir /run/php \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# memory limit php
COPY .docker/php/settings.ini /etc/php/${PHP_VERSION}/cli/conf.d/settings.ini
COPY .docker/php/settings.ini /etc/php/${PHP_VERSION}/fpm/conf.d/settings.ini

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# |--------------------------------------------------------------------------
# | prestissimo
# |--------------------------------------------------------------------------
# |
# | Installs Prestissimo to improve Composer download performance.
# |

RUN composer global require hirak/prestissimo --no-plugins --no-scripts

# Set timezone
RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone
RUN printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} > /etc/php/${PHP_VERSION}/cli/conf.d/tzone.ini


# Configure PHP-FPM
COPY .docker/php/config/php-fpm.conf /etc/php/${PHP_VERSION}/fpm/php-fpm.conf

RUN echo 'alias sf="php bin/console"' >> ~/.bashrc

ENV APP_ENV=dev

WORKDIR /var/www/html

COPY .docker/php/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

RUN apt-get update -qq \
    && curl --silent --location https://deb.nodesource.com/setup_12.x | bash \
    && apt-get install -y nodejs \
    && npm install -g yarn \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN apt-get update -qq \
    && apt-get install -y php${PHP_VERSION}-xdebug \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

COPY .docker/php/xdebug.ini /etc/php/${PHP_VERSION}/apache2/conf.d/xdebug.ini
COPY .docker/php/xdebug.ini /etc/php/${PHP_VERSION}/cli/conf.d/xdebug.ini

# Expose port 9000 and start php-fpm server
EXPOSE 9000

ENTRYPOINT ["docker-entrypoint"]

RUN ln /usr/sbin/php-fpm${PHP_VERSION} /usr/bin/php-fpm

CMD ["php-fpm"]

# Prod image
FROM dev AS prod

ENV APP_ENV=prod

WORKDIR /var/www/html

# Install composer packages (by starting with coping only composer file, to make use of docker layering feature)
COPY composer.json composer.lock symfony.lock ./
RUN composer install --prefer-dist --no-progress --no-suggest --no-interaction --no-scripts --no-dev --no-autoloader

## Remove dev dependencies and generate prod parameters file
RUN composer install --no-dev --no-interaction --optimize-autoloader && composer dump-env prod

# Cleanup
RUN composer global remove hirak/prestissimo && \
    apt-get remove -y vim git unzip htop && \
    apt-get autoremove -y && rm -rf /root/.composer && rm -rf .docker

CMD ["php-fpm"]