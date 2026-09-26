# Hyperf for Ubuntu (LTS) — 8.4 ZTS Dev Image
#
# @link     https://www.hyperf.io
# @document https://hyperf.wiki
# @contact  group@hyperf.io
# @license  https://github.com/hyperf/hyperf/blob/master/LICENSE
#
# 本文件由 8.4/ubuntu/dev/Dockerfile 译为 ZTS 版本:
#   - 基于 ZTS base (PHP 8.4.26 源码编译, --enable-zts)
#   - phpize / php-config 由 make install 自带在 /usr/local/bin, 无需软链
#   - ZTS base 以 --without-pear 构建且已清理编译工具链, 此处重装并引导 PEAR/pecl
#   - 编译扩展不经 ondrej PPA (其 php8.4-dev 只匹配 NTS), 用 phpize + 源码/pecl
ARG UBUNTU_VERSION=24.04

FROM hyperf/hyperf:8.4-zts-ubuntu-v${UBUNTU_VERSION}-base

LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT"

ARG COMPOSER_VERSION

ENV COMPOSER_VERSION=${COMPOSER_VERSION:-"2.6.6"} \
    COMPOSER_ALLOW_SUPERUSER=1

##
# ---------- env settings ----------
##
# 对齐 NTS dev 的运行工具与编译工具；phpize/php-config 已随 base 的 make install 安装
RUN set -ex \
    && apt-get update \
    # 基础运行工具(对应 NTS 版 apt add libstdc++6 openssl git bash)
    && apt-get install -y --no-install-recommends libstdc++6 openssl git bash \
    # 重装 ZTS base 清理掉的编译工具链(libaio-dev 供 swoole/event 等扩展编译)
    && apt-get install -y --no-install-recommends build-essential autoconf pkg-config libaio-dev \
    # pecl: ZTS base 以 --without-pear 构建无自带 pecl, 用官方 go-pear.phar 引导 PEAR
    # 非交互方式: stdin 喂 'all' + 12 个目录路径, 安装到 /usr/local/bin 与 /usr/local/share/pear
    && curl -fsSL --retry 3 -o /tmp/go-pear.phar \
        https://pear.php.net/go-pear.phar \
    && printf "%s\n" all /usr /tmp/pear/install /tmp/pear/install \
        /usr/local/bin /usr/local/share/pear /usr/local/docs /usr/local/data \
        /usr/local/cfg /usr/local/www /usr/local/man /usr/local/tests /etc/pear.conf "" \
        | php /tmp/go-pear.phar \
    # install composer
    && wget -nv -O /usr/local/bin/composer \
        https://github.com/composer/composer/releases/download/${COMPOSER_VERSION}/composer.phar \
    && chmod u+x /usr/local/bin/composer \
    # php info(含 pecl 版本, 确认 PEAR 引导成功)
    && php -v \
    && php -m \
    && pecl version \
    # ---------- clear works ----------
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /usr/share/man \
    # /bin/sh 为 dash, echo 不支持 -e, 改用 printf
    && printf "\033[42;37m Build Completed :).\033[0m\n"