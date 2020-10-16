# hyperf/hyperf:7.4
#
# @link     https://www.hyperf.io
# @document https://doc.hyperf.io
# @contact  group@hyperf.io
# @license  https://github.com/hyperf/hyperf/blob/master/LICENSE

ARG ALPINE_VERSION

FROM hyperf/hyperf:7.3-alpine-v${ALPINE_VERSION}-base

LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT"

ARG SW_VERSION

##
# ---------- env settings ----------
##
ENV SW_VERSION=${SW_VERSION:-"develop"} \
    #  install and remove building packages
    PHPIZE_DEPS="autoconf automake gcc g++ make php7-dev php7-pear file"

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
    && ln -s /usr/bin/phpize7 /usr/local/bin/phpize \
    && ln -s /usr/bin/php-config7 /usr/local/bin/php-config \
    && ( \
        cd swow \
        && phpize \
        && ./configure \
        && make -s -j$(nproc) && make install \
    ) \
    && echo "memory_limit=1G" > /etc/php7/conf.d/00_default.ini \
    && echo "extension=swow.so" > /etc/php7/conf.d/50_swow.ini \
    # install composer
    && cd /tmp \
    && wget https://github.com/composer/composer/releases/download/1.10.15/composer.phar \
    && chmod u+x composer.phar \
    && mv composer.phar /usr/local/bin/composer \
    # php info
    && php -v \
    && php -m \
    && php --ri swow \
    # ---------- clear works ----------
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man /usr/local/bin/php* \
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"