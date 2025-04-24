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
    php84 \
    php84-bcmath \
    php84-curl \
    php84-ctype \
    php84-dom \
    php84-fileinfo \
    php84-gd \
    php84-iconv \
    php84-mbstring \
    php84-mysqlnd \
    php84-openssl \
    php84-pdo \
    php84-pdo_mysql \
    php84-phar \
    php84-posix \
    php84-redis \
    php84-sockets \
    php84-sodium \
    php84-sysvshm \
    php84-sysvmsg \
    php84-sysvsem \
    php84-simplexml \
    php84-tokenizer \
    php84-zip \
    php84-zlib \
    php84-xml \
    php84-xmlreader \
    php84-xmlwriter \
    php84-pcntl \
    php84-opcache \
    && ln -sf /usr/bin/php84 /usr/bin/php \
    && php /init.php \
    && apk del --purge *-dev \
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man /usr/share/php84 \
    && php -v \
    && php -m \
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"
