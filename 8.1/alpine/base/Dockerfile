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
    php81 \
    php81-bcmath \
    php81-curl \
    php81-ctype \
    php81-dom \
    php81-fileinfo \
    php81-gd \
    php81-gmp \
    php81-iconv \
    php81-mbstring \
    php81-mysqlnd \
    php81-openssl \
    php81-pdo \
    php81-pdo_mysql \
    php81-phar \
    php81-posix \
    php81-redis \
    php81-sockets \
    php81-sodium \
    php81-sysvshm \
    php81-sysvmsg \
    php81-sysvsem \
    php81-simplexml \
    php81-tokenizer \
    php81-zip \
    php81-zlib \
    php81-xml \
    php81-xmlreader \
    php81-xmlwriter \
    php81-pcntl \
    php81-opcache \
    && ln -sf /usr/bin/php81 /usr/bin/php \
    && php /init.php \
    && apk del --purge *-dev \
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man /usr/share/php81 \
    && php -v \
    && php -m \
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"
