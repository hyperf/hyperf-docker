#!/usr/bin/env bash

# Login
docker login ghcr.io --username limingxinleo -p $GITHUB_TOKEN
docker docker login -u cnb docker.cnb.cool -p $CNB_TOKEN

# Push to Github
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC} ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC} ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%\.*}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC} ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%%\.*}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC} ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC} ghcr.io/hyperf/hyperf-docker/hyperf:latest

docker push ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION}
docker push ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%\.*}
docker push ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%%\.*}
docker push ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}

# Push to CNB
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC} docker.cnb.cool/hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC} docker.cnb.cool/hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%\.*}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC} docker.cnb.cool/hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%%\.*}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC} docker.cnb.cool/hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC} docker.cnb.cool/hyperf/hyperf:latest

docker push docker.cnb.cool/hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION}
docker push docker.cnb.cool/hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%\.*}
docker push docker.cnb.cool/hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%%\.*}
docker push docker.cnb.cool/hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}
