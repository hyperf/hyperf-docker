# Hyperf for Ubuntu (LTS)
#
# @link     https://www.hyperf.io
# @document https://hyperf.wiki
# @contact  group@hyperf.io
# @license  https://github.com/hyperf/hyperf/blob/master/LICENSE
#
# 与原版 Alpine Dockerfile 一一对应的 Ubuntu 版本：
#   - 包管理 apk -> apt
#   - PHP 8.4 通过 ondrej/php PPA 获取（Ubuntu 24.04 官方源默认只有 PHP 8.3）
#   - 多模块合并进 php8.4-common / php8.4-xml / php8.4-mysql，见下方注释
ARG UBUNTU_VERSION=24.04
FROM ubuntu:${UBUNTU_VERSION}

LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT"

# 避免 tzdata 等包安装时出现交互式询问
ENV DEBIAN_FRONTEND=noninteractive

## ---------- building ----------
COPY ./init.php /init.php

RUN set -ex \
    # 基础工具 gnupg/software-properties-common 用于添加 PPA
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        wget \
        tar \
        xz-utils \
        tzdata \
        gnupg \
        software-properties-common \
    # 添加 PHP 8.4 的官方 PPA
    && add-apt-repository -y ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        # cli 提供 CLI、pcntl；common 提供 ctype/fileinfo/iconv/openssl/pdo/phar/posix/sockets/sodium/sysvmsg/sysvsem/sysvshm/tokenizer/zlib
        php8.4-cli \
        php8.4-common \
        php8.4-bcmath \
        php8.4-curl \
        php8.4-gd \
        php8.4-mbstring \
        # mysql 同时提供 mysqlnd 与 pdo_mysql
        php8.4-mysql \
        php8.4-opcache \
        php8.4-redis \
        # xml 同时提供 dom/simplexml/xmlreader/xmlwriter
        php8.4-xml \
        php8.4-zip \
    # 将默认 php 指向 8.4（替代原版 ln -sf 的写法）
    && update-alternatives --set php /usr/bin/php8.4 \
    && php -v \
    && php /init.php \
    # 清理安装缓存（等价于 apk del --purge *-dev 与清 /var/cache/apk）
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /usr/share/man \
    && php -v \
    && php -m \
    # /bin/sh 为 dash，echo 不支持 -e，改用 printf
    && printf "\033[42;37m Build Completed :).\033[0m\n"
