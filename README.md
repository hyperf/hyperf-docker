# Supported tags and respective Dockerfile links

tag format:

- 7.4: php version, support 7.3/7.4
- alpine: base images, supoort alpine/centos
- v3.11: alpine version, support alpine 3.9 and 3.10 and 3.11
- swoole: support base/dev/swoole/swoole
- v4.5.5: swoole/swow version

support:

- [`7.3-alpine-v3.9-swoole-*`, `7.3-alpine-v3.9-swoole`](https://github.com/hyperf-cloud/hyperf-docker/blob/master/7.3/alpine/swoole/Dockerfile)
- [`7.3-alpine-v3.9-swow-*`, `7.3-alpine-v3.9-swow`](https://github.com/hyperf-cloud/hyperf-docker/blob/master/7.3/alpine/swow/Dockerfile)
- [`7.3-alpine-v3.9-base`](https://github.com/hyperf-cloud/hyperf-docker/blob/master/7.3/alpine/base/Dockerfile)
- [`7.4-alpine-v3.9-swoole-*`, `7.4-alpine-v3.9-swoole`](https://github.com/hyperf-cloud/hyperf-docker/blob/master/7.4/alpine/swoole/Dockerfile)
- [`7.4-alpine-v3.9-swow-*`, `7.4-alpine-v3.9-swow`](https://github.com/hyperf-cloud/hyperf-docker/blob/master/7.4/alpine/swoole/Dockerfile)
- [`7.4-alpine-v3.9-base`](https://github.com/hyperf-cloud/hyperf-docker/blob/master/7.4/alpine/base/Dockerfile)

# Quick reference

- [hyperf](https://github.com/hyperf)
- [hyperf doc](https://doc.hyperf.io)

# How to use this image

Added [Dockerfile](https://github.com/hyperf-cloud/hyperf-docker/blob/master/Dockerfile) to your project.

# How to build and push images

```bash
# Build base image
./build.sh build

# Check images
./build.sh publish --check

# Push images
./build.sh publish
```

# more demo

- kafka

```dockerfile
RUN apk add --no-cache librdkafka-dev \
&& pecl install rdkafka \
&& echo "extension=rdkafka.so" > /etc/php7/conf.d/rdkafka.ini
```

- aerospike

```dockerfile
# aerospike @see https://github.com/aerospike/aerospike-client-php/issues/24
RUN git clone https://gitlab.innotechx.com/liyibocheng/aerospike-c-client.git /tmp/aerospike-client-c \
&& ( \
    cd /tmp/aerospike-client-c \
    && make \
) \
&& export PREFIX=/tmp/aerospike-client-c/target/Linux-x86_64 \
&& export DOWNLOAD_C_CLIENT=0 \
&& git clone https://gitlab.innotechx.com/liyibocheng/aerospike-client-php.git /tmp/aerospike-client-php \
&& ( \
    cd /tmp/aerospike-client-php/src \
    && ./build.sh \
    && make install \
    && echo "extension=aerospike.so" > /etc/php7/conf.d/aerospike.ini \
    && echo "aerospike.udf.lua_user_path=/usr/local/aerospike/usr-lua" >> /etc/php7/conf.d/aerospike.ini \
)
```

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

-  swoole tracker

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
RUN apk --no-cache --allow-untrusted --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ add gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php
```
