# Hyperf for Ubuntu (LTS) — 8.4 Dev Image
#
# @link     https://www.hyperf.io
# @document https://hyperf.wiki
# @contact  group@hyperf.io
# @license  https://github.com/hyperf/hyperf/blob/master/LICENSE
#
# 本文件由 8.4/alpine/dev/Dockerfile 翻译而来:
#   - 包管理 apk -> apt (基础镜像 hyperf/hyperf:8.4-ubuntu-v${UBUNTU_VERSION}-base)
#   - PHP_BUILD_VERSION 对应 "8.4" (生成 php8.4-dev / /usr/bin/phpize8.4),pecl 来自 php-pear 包
#   - 默认 php 已由 base 镜像通过 update-alternatives 指向 8.4,故省略原版 cp 一行
ARG UBUNTU_VERSION=24.04

FROM hyperf/hyperf:8.4-ubuntu-v${UBUNTU_VERSION}-base

LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT"

ARG COMPOSER_VERSION
ARG PHP_BUILD_VERSION

ENV COMPOSER_VERSION=${COMPOSER_VERSION:-"2.6.6"} \
    COMPOSER_ALLOW_SUPERUSER=1

##
# ---------- env settings ----------
##
# 对应 Alpine 版的 PHPIZE_DEPS,包名替换为 Ubuntu 版本:
#   - php8.4-dev 由 ondrej/php PPA 提供 (含 phpize8.4 / php-config8.4)
#   - php-pear 由 ondrej/php PPA 提供 (含 pecl,无版本号后缀)
ENV PHPIZE_DEPS="autoconf dpkg-dev dpkg file g++ gcc libc6-dev make php${PHP_BUILD_VERSION}-dev php-pear pkg-config re2c libpcre3-dev libpcre2-dev zlib1g-dev libtool automake"

# update
RUN set -ex \
    && apt-get update \
    # 基础运行工具(对应 apk add libstdc++ openssl git bash)
    && apt-get install -y --no-install-recommends libstdc++6 openssl git bash \
    # 编译工具(对应 apk add $PHPIZE_DEPS libaio-dev openssl-dev curl-dev)
    && apt-get install -y --no-install-recommends $PHPIZE_DEPS libaio-dev libssl-dev libcurl4-openssl-dev \
    # 软链 PHP 构建工具到 /usr/local/bin(对应原版 ln -s)
    && ln -s /usr/bin/phpize${PHP_BUILD_VERSION} /usr/local/bin/phpize \
    && ln -s /usr/bin/php-config${PHP_BUILD_VERSION} /usr/local/bin/php-config \
    && ln -s /usr/bin/pecl /usr/local/bin/pecl \
    # install composer
    && wget -nv -O /usr/local/bin/composer https://github.com/composer/composer/releases/download/${COMPOSER_VERSION}/composer.phar \
    && chmod u+x /usr/local/bin/composer \
    # php info
    && php -v \
    && php -m \
    # ---------- clear works ----------
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /usr/share/man \
    # /bin/sh 为 dash,echo 不支持 -e,改用 printf
    && printf "\033[42;37m Build Completed :).\033[0m\n"