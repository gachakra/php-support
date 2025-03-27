ARG PHP_VERSION
ARG COMPOSER_VERSION

#######################################################################
FROM composer:${COMPOSER_VERSION} AS composer


#######################################################################
FROM php:${PHP_VERSION}-cli AS php-base

LABEL maintainer="gachakra <gachakra.kangin@notonza.dev>"

RUN apt-get update  \
    && apt-get install -y zlib1g-dev libzip-dev mariadb-client unzip git \
    && docker-php-ext-install zip pdo_mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


COPY --from=composer /usr/bin/composer /usr/local/bin/composer

WORKDIR /var/www/php-support