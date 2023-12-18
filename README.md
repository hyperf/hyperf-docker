# hyperf-docker

## Supported tags and respective Dockerfile links

tag format:

- 8.1: php version, support 8.0/8.1/8.2, Recommend 8.1
- alpine: base images, supoort alpine/ubuntu, recommend alpine
- v3.16: alpine version, support alpine 3.14/3.15/3.16/3.17/edge, recommend 3.16
- swoole: support base/dev/swoole/swow
- v5.0.2: swoole/swow version

support:

- [`8.1-alpine-v3.16-swoole-*`, `8.1-alpine-v3.16-swoole`](https://github.com/hyperf/hyperf-docker/blob/master/8.1/alpine/swoole/Dockerfile)
- [`8.1-alpine-v3.16-swow-*`, `8.1-alpine-v3.16-swow`](https://github.com/hyperf/hyperf-docker/blob/master/8.1/alpine/swow/Dockerfile)
- [`8.1-alpine-v3.16-base`](https://github.com/hyperf/hyperf-docker/blob/master/8.1/alpine/base/Dockerfile)
- [`8.2-alpine-vedge-swoole-*`, `8.2-alpine-vedge-swoole`](https://github.com/hyperf/hyperf-docker/blob/master/8.2/alpine/swoole/Dockerfile)
- [`8.2-alpine-vedge-swow-*`, `8.1-alpine-vedge-swow`](https://github.com/hyperf/hyperf-docker/blob/master/8.2/alpine/swow/Dockerfile)
- [`8.2-alpine-vedge-base`](https://github.com/hyperf/hyperf-docker/blob/master/8.2/alpine/base/Dockerfile)

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
igbinary
json
libxml
mbstring
mysqlnd
openssl
pcntl
pcre
PDO
pdo_mysql
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

The Swoole info like the code below:

```shell
swoole

Swoole => enabled
Author => Swoole Team <team@swoole.com>
Version => 5.1.1
Built => Dec 11 2023 01:47:26
coroutine => enabled with boost asm context
epoll => enabled
eventfd => enabled
signalfd => enabled
spinlock => enabled
rwlock => enabled
openssl => OpenSSL 3.1.4 24 Oct 2023
dtls => enabled
http2 => enabled
json => enabled
curl-native => enabled
pcre => enabled
c-ares => 1.19.1
zlib => 1.2.13
brotli => E16777225/D16777225
mutex_timedlock => enabled
pthread_barrier => enabled
async_redis => enabled
coroutine_pgsql => enabled

Directive => Local Value => Master Value
swoole.enable_coroutine => On => On
swoole.enable_library => On => On
swoole.enable_fiber_mock => Off => Off
swoole.enable_preemptive_scheduler => Off => Off
swoole.display_errors => On => On
swoole.use_shortname => Off => Off
swoole.unixsock_buffer_size => 8388608 => 8388608
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
