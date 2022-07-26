#!/usr/bin/env bash

# Login
docker login --username limingxinleo -p $DOCKERHUB_TOKEN

# Push to DockerHub
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION} hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION%\.*}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION} hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION%%\.*}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION} hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}
docker push hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION}
docker push hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION%\.*}
docker push hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION%%\.*}
docker push hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}
