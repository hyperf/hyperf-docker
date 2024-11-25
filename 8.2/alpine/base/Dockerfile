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
    php82 \
    php82-bcmath \
    php82-curl \
    php82-ctype \
    php82-dom \
    php82-fileinfo \
    php82-gd \
    php82-gmp \
    php82-iconv \
    php82-mbstring \
    php82-mysqlnd \
    php82-openssl \
    php82-pdo \
    php82-pdo_mysql \
    php82-phar \
    php82-posix \
    php82-redis \
    php82-sockets \
    php82-sodium \
    php82-sysvshm \
    php82-sysvmsg \
    php82-sysvsem \
    php82-simplexml \
    php82-tokenizer \
    php82-zip \
    php82-zlib \
    php82-xml \
    php82-xmlreader \
    php82-xmlwriter \
    php82-pcntl \
    php82-opcache \
    && ln -sf /usr/bin/php82 /usr/bin/php \
    && php /init.php \
    && apk del --purge *-dev \
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man /usr/share/php82 \
    && php -v \
    && php -m \
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"
