# hyperf/hyperf:8.4
#
# @link     https://www.hyperf.io
# @document https://hyperf.wiki
# @contact  group@hyperf.io
# @license  https://github.com/hyperf/hyperf/blob/master/LICENSE

ARG ALPINE_VERSION

FROM hyperf/hyperf:8.4-alpine-v${ALPINE_VERSION}-base

LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT"

ARG COMPOSER_VERSION
ARG PHP_BUILD_VERSION

ENV COMPOSER_VERSION=${COMPOSER_VERSION:-"2.6.6"} \
    COMPOSER_ALLOW_SUPERUSER=1

##
# ---------- env settings ----------
##
ENV PHPIZE_DEPS="autoconf dpkg-dev dpkg file g++ gcc libc-dev make php${PHP_BUILD_VERSION}-dev php${PHP_BUILD_VERSION}-pear pkgconf re2c pcre-dev pcre2-dev zlib-dev libtool automake"

# update
RUN set -ex \
    && apk update \
    && apk add --no-cache libstdc++ openssl git bash \
    && apk add --no-cache $PHPIZE_DEPS libaio-dev openssl-dev curl-dev \
    && ln -s /usr/bin/phpize${PHP_BUILD_VERSION} /usr/local/bin/phpize \
    && ln -s /usr/bin/php-config${PHP_BUILD_VERSION} /usr/local/bin/php-config \
    && ln -s /usr/bin/pecl${PHP_BUILD_VERSION} /usr/local/bin/pecl \
    # install composer
    && wget -nv -O /usr/local/bin/composer https://github.com/composer/composer/releases/download/${COMPOSER_VERSION}/composer.phar \
    && chmod u+x /usr/local/bin/composer \
    # php info
    && php -v \
    && php -m \
    # ---------- clear works ----------
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man \
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"
