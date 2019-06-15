# hyperf-cloud/hyperf:7.2-base-centos
#
# @link     https://www.hyperf.io
# @document https://doc.hyperf.io
# @contact  group@hyperf.io
# @license  https://github.com/hyperf-cloud/hyperf/blob/master/LICENSE

FROM centos:7

LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT"

ENV PHP_VERSION=php72

##
# ---------- building ----------
##
RUN set -ex \
    # change php source repo
    && rpm --import https://rpms.remirepo.net/RPM-GPG-KEY-remi \
    && rpm -ivh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && rpm -ivh https://mirrors.tuna.tsinghua.edu.cn/remi/enterprise/remi-release-7.rpm \
    && yum install -y vim \
    ${PHP_VERSION} \
    ${PHP_VERSION}-php-devel \
    ${PHP_VERSION}-php-fpm \
    ${PHP_VERSION}-php-gd \
    ${PHP_VERSION}-php-pdo \
    ${PHP_VERSION}-php-mysql \
    ${PHP_VERSION}-php-xml \
    ${PHP_VERSION}-php-mbstring \
    ${PHP_VERSION}-php-zip \
    ${PHP_VERSION}-php-opcache \
    ${PHP_VERSION}-php-redis \
    ${PHP_VERSION}-php-process \
    ${PHP_VERSION}-php-bcmath \
    ca-certificates \
    curl \
    tar \
    xz \
    tzdata \
    pcre \
    && ln -s /usr/bin/php72 /usr/local/bin/php \
    && ln -s /opt/remi/php72/root/bin/phpize /usr/local/bin/phpize \
    && ln -s /opt/remi/php72/root/bin/php-config /usr/local/bin/php-config \
    && ln -s /opt/remi/php72/root/sbin/php-fpm /usr/local/sbin/php-fpm \
    && rm -rf /tmp/* /usr/share/man /usr/share/php7 \
    && php -v \
    && php -m \
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"