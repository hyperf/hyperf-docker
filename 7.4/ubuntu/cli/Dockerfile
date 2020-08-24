# hyperf/hyperf:7.4
#
# @link     https://www.hyperf.io
# @document https://doc.hyperf.io
# @contact  group@hyperf.io
# @license  https://github.com/hyperf/hyperf/blob/master/LICENSE

ARG UBUNTU_VERSION

FROM hyperf/hyperf:7.4-ubuntu-v${UBUNTU_VERSION}-base

LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT"

ARG SWOOLE_VERSION

##
# ---------- env settings ----------
##
ENV SWOOLE_VERSION=${SWOOLE_VERSION:-"4.5.2"} \
    #  install and remove building packages
    PHPIZE_DEPS="autoconf dpkg-dev dpkg file g++ gcc libc-dev make php7.4-dev pkgconf re2c libtool automake libaio-dev"

# update
RUN set -ex \
    && apt-get update \
    && apt-get install -y git \
    && apt-get install -y $PHPIZE_DEPS \
    # download
    && cd /tmp \
    && curl -SL "https://github.com/swoole/swoole-src/archive/v${SWOOLE_VERSION}.tar.gz" -o swoole.tar.gz \
    && ls -alh \
    # php extension:swoole
    && cd /tmp \
    && mkdir -p swoole \
    && tar -xf swoole.tar.gz -C swoole --strip-components=1 \
    && ( \
        cd swoole \
        && phpize \
        && ./configure --enable-mysqlnd --enable-openssl --enable-http2 \
        && make -s -j$(nproc) && make install \
    ) \
    && echo "memory_limit=1G" > /etc/php/7.4/cli/conf.d/00-default.ini \
    && echo "extension=swoole.so" > /etc/php/7.4/cli/conf.d/50-swoole.ini \
    && echo "swoole.use_shortname = 'Off'" >> /etc/php/7.4/cli/conf.d/50-swoole.ini \
    # clear
    && php -v \
    && php -m \
    && php --ri swoole \
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"
