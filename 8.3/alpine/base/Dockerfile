# hyperf/hyperf:8.1
#
# @link     https://www.hyperf.io
# @document https://hyperf.wiki
# @contact  group@hyperf.io
# @license  https://github.com/hyperf/hyperf/blob/master/LICENSE

ARG ALPINE_VERSION

FROM alpine:$ALPINE_VERSION

LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT"

##
# ---------- building ----------
##
COPY ./init.php /init.php

RUN set -ex \
    && apk update \
    && apk add --no-cache \
    # Install base packages ('ca-certificates' will install 'nghttp2-libs')
    ca-certificates \
    curl \
    wget \
    tar \
    xz \
    tzdata \
    pcre \
    php83 \
    php83-bcmath \
    php83-curl \
    php83-ctype \
    php83-dom \
    php83-fileinfo \
    php83-gd \
    php83-gmp \
    php83-iconv \
    php83-mbstring \
    php83-mysqlnd \
    php83-openssl \
    php83-pdo \
    php83-pdo_mysql \
    php83-phar \
    php83-posix \
    php83-redis \
    php83-sockets \
    php83-sodium \
    php83-sysvshm \
    php83-sysvmsg \
    php83-sysvsem \
    php83-simplexml \
    php83-tokenizer \
    php83-zip \
    php83-zlib \
    php83-xml \
    php83-xmlreader \
    php83-xmlwriter \
    php83-pcntl \
    php83-opcache \
    && ln -sf /usr/bin/php83 /usr/bin/php \
    && php /init.php \
    && apk del --purge *-dev \
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man /usr/share/php83 \
    && php -v \
    && php -m \
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"
