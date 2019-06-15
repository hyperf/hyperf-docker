# hyperf-cloud/hyperf:7.3-base-alpine
#
# @link     https://www.hyperf.io
# @document https://doc.hyperf.io
# @contact  group@hyperf.io
# @license  https://github.com/hyperf-cloud/hyperf/blob/master/LICENSE

FROM alpine:3.9

LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT"

# trust this project public key to trust the packages.
ADD https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

##
# ---------- building ----------
##
RUN set -ex \
    # change apk source repo
    && echo "https://dl.bintray.com/php-alpine/v3.9/php-7.3" >> /etc/apk/repositories \
    && echo "@php https://dl.bintray.com/php-alpine/v3.9/php-7.3" >> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache \
    # Install base packages ('ca-certificates' will install 'nghttp2-libs')
    ca-certificates \
    curl \
    tar \
    xz \
    libressl \
    tzdata \
    pcre \
    php7 \
    php7-bcmath \
    php7-curl \
    php7-ctype \
    php7-dom \
    php7-fileinfo \
    php7-gd \
    php7-iconv \
    php7-json \
    php7-mbstring \
    php7-mysqlnd \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-pdo_sqlite \
    php7-phar \
    php7-posix \
    php7-redis \
    php7-simplexml \
    php7-sockets \
    php7-sodium \
    php7-sysvshm \
    php7-sysvmsg \
    php7-sysvsem \
    php7-tokenizer \
    php7-zip \
    php7-zlib \
    php7-xml \
    php7-xmlreader \
    php7-xmlwriter \
    php7-pcntl \
    && apk del --purge *-dev \
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man /usr/share/php7 \
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"