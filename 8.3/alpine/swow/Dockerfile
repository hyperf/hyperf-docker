# hyperf/hyperf:8.2
#
# @link     https://www.hyperf.io
# @document https://hyperf.wiki
# @contact  group@hyperf.io
# @license  https://github.com/hyperf/hyperf/blob/master/LICENSE

ARG ALPINE_VERSION

FROM hyperf/hyperf:8.2-alpine-v${ALPINE_VERSION}-base

LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT"

ARG SW_VERSION
ARG COMPOSER_VERSION
ARG PHP_BUILD_VERSION

##
# ---------- env settings ----------
##
ENV SW_VERSION=${SW_VERSION:-"develop"} \
    COMPOSER_VERSION=${COMPOSER_VERSION:-"2.0.2"} \
    COMPOSER_ALLOW_SUPERUSER=1 \
    #  install and remove building packages
    PHPIZE_DEPS="autoconf automake gcc g++ make php${PHP_BUILD_VERSION}-dev php${PHP_BUILD_VERSION}-pear file re2c openssl-dev curl-dev"

# update
RUN set -ex \
    && apk update \
    # for swow extension libaio linux-headers
    && apk add --no-cache openssl git bash \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    # download
    && cd /tmp \
    && curl -SL "https://github.com/swow/swow/archive/${SW_VERSION}.tar.gz" -o swow.tar.gz \
    && ls -alh \
    # php extension:swow
    && cd /tmp \
    && mkdir -p swow \
    && tar -xf swow.tar.gz -C swow --strip-components=1 \
    && ln -s /usr/bin/phpize${PHP_BUILD_VERSION} /usr/local/bin/phpize \
    && ln -s /usr/bin/php-config${PHP_BUILD_VERSION} /usr/local/bin/php-config \
    && ( \
        cd swow/ext \
        && phpize \
        && ./configure --enable-swow --enable-swow-ssl --enable-swow-curl \
        && make -s -j$(nproc) && make install \
    ) \
    && echo "memory_limit=1G" > /etc/php${PHP_BUILD_VERSION}/conf.d/00_default.ini \
    && echo "opcache.enable_cli = 'On'" >> /etc/php${PHP_BUILD_VERSION}/conf.d/00_opcache.ini \
    && echo "extension=swow.so" > /etc/php${PHP_BUILD_VERSION}/conf.d/50_swow.ini \
    # install composer
    && wget -nv -O /usr/local/bin/composer https://github.com/composer/composer/releases/download/${COMPOSER_VERSION}/composer.phar \
    && chmod u+x /usr/local/bin/composer \
    # php info
    && php -v \
    && php -m \
    && php --ri swow \
    && composer \
    # ---------- clear works ----------
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man /usr/local/bin/php* \
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"
