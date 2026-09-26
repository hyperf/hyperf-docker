# Hyperf for Ubuntu (LTS) — 8.4 Swoole Image
#
# @link     https://www.hyperf.io
# @document https://hyperf.wiki
# @contact  group@hyperf.io
# @license  https://github.com/hyperf/hyperf/blob/master/LICENSE
#
# 本文件由 8.4/alpine/swoole/Dockerfile 翻译而来:
#   - 包管理 apk -> apt (基础镜像 hyperf/hyperf:8.4-ubuntu-v${UBUNTU_VERSION}-base)
#   - PHP_BUILD_VERSION 为 "8.4"(对应 php8.4-dev / /usr/bin/phpize8.4),配置目录为
#     /etc/php/8.4/cli/conf.d (Ubuntu CLI 与 FPM 的 ini 目录分离)
#   - php84-pdo_pgsql / php84-pdo_sqlite / php84-pdo_odbc
#     -> php8.4-pgsql / php8.4-sqlite3 / php8.4-odbc
#   - c-ares-dev / libpq-dev 保留安装(与原版一致),其余编译依赖 purge 清理
#   - 默认 php 已由 base 指向 8.4,省略原版 cp 一行
ARG UBUNTU_VERSION=24.04

FROM hyperf/hyperf:8.4-ubuntu-v${UBUNTU_VERSION}-base

LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT"

ARG SW_VERSION
ARG COMPOSER_VERSION
ARG PHP_BUILD_VERSION=8.4

##
# ---------- env settings ----------
##
ENV SW_VERSION=${SW_VERSION:-"v6.2.3"} \
    COMPOSER_VERSION=${COMPOSER_VERSION:-"2.6.6"} \
    COMPOSER_ALLOW_SUPERUSER=1 \
    #  install and remove building packages
    PHPIZE_DEPS="autoconf dpkg-dev dpkg file g++ gcc libc6-dev make php${PHP_BUILD_VERSION}-dev php-pear pkg-config re2c libpcre3-dev libpcre2-dev zlib1g-dev libtool automake"

# update
RUN set -ex \
    && apt-get update \
    # for swoole extension libaio linux-headers (c-ares/libpq 保留安装,与原版 alpine 一致)
    && apt-get install -y --no-install-recommends libstdc++6 openssl git bash libc-ares-dev libpq-dev php8.4-pgsql php8.4-sqlite3 php8.4-odbc \
    # 编译工具(对应 apk add $PHPIZE_DEPS unixodbc-dev sqlite-dev)
    && apt-get install -y --no-install-recommends $PHPIZE_DEPS libaio-dev libssl-dev libcurl4-openssl-dev unixodbc-dev libsqlite3-dev \
    # download
    && cd /tmp \
    && curl -SL "https://github.com/swoole/swoole-src/archive/${SW_VERSION}.tar.gz" -o swoole.tar.gz \
    && ls -alh \
    # php extension:swoole
    && cd /tmp \
    && mkdir -p swoole \
    && tar -xf swoole.tar.gz -C swoole --strip-components=1 \
    && ln -s /usr/bin/phpize${PHP_BUILD_VERSION} /usr/local/bin/phpize \
    && ln -s /usr/bin/php-config${PHP_BUILD_VERSION} /usr/local/bin/php-config \
    && ( \
        cd swoole \
        && phpize \
        # Ubuntu 为 multiarch 库路径,而 --with-swoole-odbc=unixodbc,/usr 固定查 /usr/lib,需软链
        && ln -s /usr/lib/$(dpkg-architecture -qDEB_HOST_MULTIARCH)/libodbc.so /usr/lib/libodbc.so \
        && ln -s /usr/lib/$(dpkg-architecture -qDEB_HOST_MULTIARCH)/libodbccr.so /usr/lib/libodbccr.so \
        && ./configure --enable-swoole-curl --enable-cares --enable-swoole-pgsql --enable-swoole-sqlite --with-swoole-odbc=unixodbc,/usr \
        && make -s -j$(nproc) && make install \
    ) \
    && mkdir -p /etc/php/${PHP_BUILD_VERSION}/cli/conf.d \
    && echo "memory_limit=1G" > /etc/php/${PHP_BUILD_VERSION}/cli/conf.d/00_default.ini \
    && echo "max_input_vars=PHP_INT_MAX" >> /etc/php/${PHP_BUILD_VERSION}/cli/conf.d/00_default.ini \
    && echo "opcache.enable_cli = 'On'" > /etc/php/${PHP_BUILD_VERSION}/cli/conf.d/20_opcache.ini \
    && echo "extension=swoole.so" > /etc/php/${PHP_BUILD_VERSION}/cli/conf.d/50_swoole.ini \
    && echo "swoole.use_shortname = 'Off'" >> /etc/php/${PHP_BUILD_VERSION}/cli/conf.d/50_swoole.ini \
    # install composer
    && wget -nv -O /usr/local/bin/composer https://github.com/composer/composer/releases/download/${COMPOSER_VERSION}/composer.phar \
    && chmod u+x /usr/local/bin/composer \
    # ---------- clear works ----------
    && apt-get purge -y --auto-remove $PHPIZE_DEPS libaio-dev libssl-dev libcurl4-openssl-dev unixodbc-dev libsqlite3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /usr/share/man /usr/local/bin/phpize /usr/local/bin/php-config \
    && rm -f /usr/lib/libodbc.so /usr/lib/libodbccr.so \
    # php info
    && php -v \
    && php -m \
    && php --ri swoole \
    && php --ri Zend\ OPcache \
    && composer \
    # /bin/sh 为 dash,echo 不支持 -e,改用 printf
    && printf "\033[42;37m Build Completed :).\033[0m\n"