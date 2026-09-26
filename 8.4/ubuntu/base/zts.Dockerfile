# Hyperf for Ubuntu (LTS) — PHP 8.4 ZTS Base Image
#
# @link     https://www.hyperf.io
# @document https://hyperf.wiki
# @contact  group@hyperf.io
# @license  https://github.com/hyperf/hyperf/blob/master/LICENSE
#
# 与 8.4/ubuntu/base/Dockerfile (NTS) 对齐的 ZTS 版本：
#   - Ubuntu 官方源与 ondrej/php PPA 均只提供 NTS 包，ZTS 只能从源码编译 (--enable-zts)
#   - 扩展清单对齐 NTS base：bcmath / curl / gd / mbstring / mysqlnd + mysqli + pdo_mysql /
#     opcache / pcntl / redis / xml 组(dom/simplexml/xmlreader/xmlwriter) / ctype / fileinfo /
#     iconv / openssl / pdo / phar / posix / sockets / sodium / sysvmsg / sysvsem / sysvshm /
#     tokenizer / zlib / zip
#   - redis 不在 php.net 源码包内，走 PECL tarball + phpize 单独编译
ARG UBUNTU_VERSION=24.04
FROM ubuntu:${UBUNTU_VERSION}

LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT"

# 源码版本固定、可复现；升级只需改这里（php.net/distributions 可获取）
ARG PHP_VERSION=8.4.26
ARG REDIS_VERSION=6.3.0

# 避免 tzdata 等包安装时出现交互式询问
ENV DEBIAN_FRONTEND=noninteractive

## ---------- building ----------
COPY ./init.php /init.php

RUN set -ex \
    # 基础工具（下载与解压）
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        wget \
        tar \
        xz-utils \
        tzdata \
    # 编译基座 + 各扩展 dev 库（释放 tarball 自带 configure，无需 bison/re2c）
    && apt-get install -y --no-install-recommends \
        build-essential \
        autoconf \
        pkg-config \
        # openssl 扩展 + curl 的 ssl 后端（OpenSSL 3，init.php 会开 legacy provider）
        libssl-dev \
        libcurl4-openssl-dev \
        # gd：--with-external-gd 用系统 libgd（对齐 NTS 的 ondrej php8.4-gd，且规避 bundled libgd 缺陷）
        libgd-dev \
        libpng-dev \
        libjpeg-dev \
        libwebp-dev \
        libfreetype-dev \
        # mbstring：PHP 8.4 不再内置 oniguruma，mbregex 依赖系统 libonig
        libonig-dev \
        # zip：--with-zip 使用系统 libzip
        libzip-dev \
        # zlib：phar / zip / gd 共同依赖
        zlib1g-dev \
        # sodium：pkg-config 检测，需 >= 1.0.18（Ubuntu 24.04 提供 1.0.18）
        libsodium-dev \
        # dom/simplexml/xmlreader/xmlwriter 依赖 libxml2
        libxml2-dev \
        # sqlite3：PHP 8.4 默认启用 sqlite3 扩展（pkg-config 检测要求）
        libsqlite3-dev \
    # ---------- 下载 PHP 源码 ----------
    && cd /tmp \
    && curl -fSL --retry 3 -o php.tar.gz \
        https://www.php.net/distributions/php-${PHP_VERSION}.tar.gz \
    && mkdir -p /tmp/php-src \
    && tar -xzf php.tar.gz -C /tmp/php-src --strip-components=1 \
    # ---------- 下载 phpredis 源码 ----------
    && curl -fSL --retry 3 -o /tmp/redis.tgz \
        https://pecl.php.net/get/redis-${REDIS_VERSION}.tgz \
    && mkdir -p /tmp/redis-src \
    && tar -xzf /tmp/redis.tgz -C /tmp/redis-src --strip-components=1 \
    # ---------- 编译 PHP（ZTS）----------
    && cd /tmp/php-src \
    && ./configure \
        --prefix=/usr/local \
        --with-config-file-path=/usr/local/etc/php \
        --with-config-file-scan-dir=/usr/local/etc/php/conf.d \
        --disable-cgi \
        --without-pear \
        --enable-zts \
        --enable-bcmath \
        --enable-mbstring \
        --enable-opcache \
        --enable-pcntl \
        --enable-sockets \
        --enable-sysvmsg \
        --enable-sysvsem \
        --enable-sysvshm \
        --enable-dom \
        --enable-simplexml \
        --enable-xmlreader \
        --enable-xmlwriter \
        --with-curl \
        --with-openssl \
        --with-mysqli=mysqlnd \
        --with-pdo-mysql=mysqlnd \
        --with-sodium \
        --with-zip \
        --with-zlib \
        --enable-gd \
        --with-external-gd \
        --with-freetype \
        --with-jpeg \
        --with-webp \
        --enable-embed=shared \
    && make -s -j$(nproc) \
    && make install \
    # ---------- 初始化 php 配置 ----------
    # 复制生产 php.ini 作为基线；opcache/redis 是 .so，其余扩展已静态编进二进制
    && mkdir -p /usr/local/etc/php/conf.d \
    && cp /tmp/php-src/php.ini-production /usr/local/etc/php/php.ini \
    && printf 'zend_extension=opcache.so\nopcache.enable_cli=1\n' > /usr/local/etc/php/conf.d/opcache.ini \
    && printf 'extension=redis.so\n' > /usr/local/etc/php/conf.d/redis.ini \
    # ---------- 编译 redis 扩展（phpize 用刚安装的工具链）----------
    && cd /tmp/redis-src \
    && /usr/local/bin/phpize \
    && ./configure --with-php-config=/usr/local/bin/php-config \
    && make -s -j$(nproc) \
    && make install \
    # ---------- 对齐 base 的行为 ----------
    && php -v \
    && php /init.php \
    # ---------- 清理编译工具，保留运行库 ----------
    # lib*-dev 保留(runtime .so 来源)；仅移除纯编译工具链
    && apt-get purge -y --auto-remove build-essential autoconf pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /usr/share/man \
    # ---------- 验证 ----------
    && php -v \
    && php -i | grep -i "Thread Safety" \
    && php -m \
    # /bin/sh 为 dash，echo 不支持 -e，改用 printf
    && printf "\033[42;37m Build Completed :).\033[0m\n"