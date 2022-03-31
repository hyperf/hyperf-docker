# hyperf-docker

## Supported tags and respective Dockerfile links

tag format:

- 8.0: php version, support 7.3/7.4/8.0/8.1, Recommend 8.0
- alpine: base images, supoort alpine/ubuntu, recommend alpine
- v3.15: alpine version, support alpine 3.10/3.11/3.12/3.13/3.14/3.15, recommend 3.15
- swoole: support base/dev/swoole/swow
- v4.8.4: swoole/swow version

support:

- [`7.3-alpine-v3.11-swoole-*`, `7.3-alpine-v3.11-swoole`](https://github.com/hyperf/hyperf-docker/blob/master/7.3/alpine/swoole/Dockerfile)
- [`7.3-alpine-v3.11-swow-*`, `7.3-alpine-v3.11-swow`](https://github.com/hyperf/hyperf-docker/blob/master/7.3/alpine/swow/Dockerfile)
- [`7.3-alpine-v3.11-base`](https://github.com/hyperf/hyperf-docker/blob/master/7.3/alpine/base/Dockerfile)
- [`7.4-alpine-v3.14-swoole-*`, `7.4-alpine-v3.14-swoole`](https://github.com/hyperf/hyperf-docker/blob/master/7.4/alpine/swoole/Dockerfile)
- [`7.4-alpine-v3.14-swow-*`, `7.4-alpine-v3.14-swow`](https://github.com/hyperf/hyperf-docker/blob/master/7.4/alpine/swoole/Dockerfile)
- [`7.4-alpine-v3.14-base`](https://github.com/hyperf/hyperf-docker/blob/master/7.4/alpine/base/Dockerfile)
- [`8.0-alpine-v3.14-swoole-*`, `8.0-alpine-v3.14-swoole`](https://github.com/hyperf/hyperf-docker/blob/master/8.0/alpine/swoole/Dockerfile)
- [`8.0-alpine-v3.14-swow-*`, `8.0-alpine-v3.14-swow`](https://github.com/hyperf/hyperf-docker/blob/master/8.0/alpine/swoole/Dockerfile)
- [`8.0-alpine-v3.14-base`](https://github.com/hyperf/hyperf-docker/blob/master/8.0/alpine/base/Dockerfile)

## Quick reference

- [hyperf](https://github.com/hyperf)
- [hyperf doc](https://hyperf.wiki)

## How to use this image

Added [Dockerfile](https://github.com/hyperf/hyperf-docker/blob/master/Dockerfile) to your project.

## Info

Base image contains extensions below:

```
[PHP Modules]
bcmath
Core
ctype
curl
date
dom
fileinfo
filter
gd
hash
iconv
json
libxml
mbstring
mysqlnd
openssl
pcntl
pcre
PDO
pdo_mysql
pdo_sqlite
Phar
posix
readline
redis
Reflection
session
SimpleXML
sockets
sodium
SPL
standard
sysvmsg
sysvsem
sysvshm
tokenizer
xml
xmlreader
xmlwriter
Zend OPcache
zip
zlib

[Zend Modules]
Zend OPcache
```

## more demo

### PHP 8.x

> For PHP 8.x you have to install `$PHPIZE_DEPS` and use `pecl8` instead of <s>`pecl`</s>.

- grpc

```dockerfile
RUN apk add --no-cache $PHPIZE_DEPS \
&& pecl8 install grpc \
&& echo "extension=grpc.so" > /etc/php8/conf.d/grpc.ini
```

### PHP 7.x

- kafka

```dockerfile
RUN apk add --no-cache librdkafka-dev \
&& pecl install rdkafka \
&& echo "extension=rdkafka.so" > /etc/php7/conf.d/rdkafka.ini
```

- aerospike: https://github.com/aerospike/aerospike-client-php/issues/24

- mongodb

```dockerfile
RUN apk add --no-cache openssl-dev \
&& pecl install mongodb \
&& echo "extension=mongodb.so" > /etc/php7/conf.d/mongodb.ini
```

- protobuf

```dockerfile
# mac protobuf: https://blog.csdn.net/JoeBlackzqq/article/details/83118248
RUN apk add --no-cache protobuf \
&& cd /tmp \
&& pecl install protobuf \
&& echo "extension=protobuf.so" > /etc/php7/conf.d/protobuf.ini
```

- swoole tracker

```dockerfile
# download swoole tracker
ADD ./swoole-tracker-install.sh /tmp

RUN chmod +x /tmp/swoole-tracker-install.sh \
&& cd /tmp \
&& ./swoole-tracker-install.sh \
&& rm /tmp/swoole-tracker-install.sh \
# config
&& cp /tmp/swoole-tracker/swoole_tracker72.so /usr/lib/php7/modules/swoole_tracker72.so \
&& echo "extension=swoole_tracker72.so" > /etc/php7/conf.d/swoole-tracker.ini \
&& echo "apm.enable=1" >> /etc/php7/conf.d/swoole-tracker.ini \
&& echo "apm.sampling_rate=100" >> /etc/php7/conf.d/swoole-tracker.ini \
&& echo "apm.enable_memcheck=1" >> /etc/php7/conf.d/swoole-tracker.ini \
# launch
&& printf '#!/bin/sh\n/opt/swoole/script/php/swoole_php /opt/swoole/node-agent/src/node.php' > /opt/swoole/entrypoint.sh \
&& chmod 755 /opt/swoole/entrypoint.sh
```

- fix aliyun oss wrong charset

```dockerfile
# fix aliyun oss wrong charset: https://github.com/aliyun/aliyun-oss-php-sdk/issues/101
# https://github.com/docker-library/php/issues/240#issuecomment-762438977

RUN apk --no-cache --allow-untrusted --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ add gnu-libiconv=1.15-r2
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so
```
