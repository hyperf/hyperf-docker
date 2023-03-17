#!/usr/bin/env bash

# Login
docker login --username limingxinleo -p $DOCKERHUB_TOKEN
docker login ghcr.io --username limingxinleo -p $GITHUB_TOKEN

# Push to DockerHub
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION} hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION%\.*}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION} hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION%%\.*}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION} hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}
docker push hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION}
docker push hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION%\.*}
docker push hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION%%\.*}
docker push hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}

# Push to Github
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION} ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION%\.*}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION} ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION%%\.*}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION} ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}
docker push ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION}
docker push ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION%\.*}
docker push ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}-${SW_VERSION%%\.*}
docker push ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}
