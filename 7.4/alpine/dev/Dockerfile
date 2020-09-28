# hyperf/hyperf:7.4
#
# @link     https://www.hyperf.io
# @document https://doc.hyperf.io
# @contact  group@hyperf.io
# @license  https://github.com/hyperf/hyperf/blob/master/LICENSE

ARG ALPINE_VERSION

FROM hyperf/hyperf:7.4-alpine-v${ALPINE_VERSION}-base

LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT"

##
# ---------- env settings ----------
##
ENV PHPIZE_DEPS="autoconf dpkg-dev dpkg file g++ gcc libc-dev make php7-dev php7-pear pkgconf re2c pcre-dev pcre2-dev zlib-dev libtool automake"

# update
RUN set -ex \
    && apk update \
    && apk add --no-cache libstdc++ openssl git bash \
    && apk add --no-cache $PHPIZE_DEPS libaio-dev openssl-dev \
    && ln -s /usr/bin/phpize7 /usr/local/bin/phpize \
    && ln -s /usr/bin/php-config7 /usr/local/bin/php-config \
    # install composer
    && cd /tmp \
    && wget https://github.com/composer/composer/releases/download/1.10.13/composer.phar \
    && chmod u+x composer.phar \
    && mv composer.phar /usr/local/bin/composer \
    # php info
    && php -v \
    && php -m \
    # ---------- clear works ----------
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man \
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"
