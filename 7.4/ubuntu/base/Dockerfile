# hyperf/hyperf:7.4
#
# @link     https://www.hyperf.io
# @document https://doc.hyperf.io
# @contact  group@hyperf.io
# @license  https://github.com/hyperf/hyperf/blob/master/LICENSE

ARG UBUNTU_VERSION

FROM ubuntu:$UBUNTU_VERSION

LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT"

ENV DEBIAN_FRONTEND=noninteractive

RUN set -ex \
    && apt-get update \
    && apt-get install -y tzdata curl wget \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt-get install -y php7.4 \
    php7.4-bcmath \
    php7.4-curl \
    php7.4-dom \
    php7.4-gd \
    php7.4-mbstring \
    php7.4-mysql \
    php7.4-redis \
    php7.4-zip


