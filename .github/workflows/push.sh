#!/usr/bin/env bash

# Login
docker login --username limingxinleo -p $DOCKERHUB_TOKEN
docker login ghcr.io --username limingxinleo -p $GITHUB_TOKEN
docker login hyperf-cloud-docker.pkg.coding.net --username hyperf-1718463997529 -p $CODING_PASSWORD

# Push to DockerHub
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION} hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%\.*}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION} hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%%\.*}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION} hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION} hyperf/hyperf:latest

docker push hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION}
docker push hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%\.*}
docker push hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%%\.*}
docker push hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}

# Push to Github
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION} ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION} ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%\.*}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION} ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%%\.*}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION} ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION} ghcr.io/hyperf/hyperf-docker/hyperf:latest

docker push ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION}
docker push ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%\.*}
docker push ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%%\.*}
docker push ghcr.io/hyperf/hyperf-docker/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}

# Push to Coding
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION} hyperf-cloud-docker.pkg.coding.net/hyperf/hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION} hyperf-cloud-docker.pkg.coding.net/hyperf/hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%\.*}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION} hyperf-cloud-docker.pkg.coding.net/hyperf/hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%%\.*}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION} hyperf-cloud-docker.pkg.coding.net/hyperf/hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}
docker tag hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION} hyperf-cloud-docker.pkg.coding.net/hyperf/hyperf/hyperf:latest

docker push hyperf-cloud-docker.pkg.coding.net/hyperf/hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION}
docker push hyperf-cloud-docker.pkg.coding.net/hyperf/hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%\.*}
docker push hyperf-cloud-docker.pkg.coding.net/hyperf/hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}-${SW_VERSION%%\.*}
docker push hyperf-cloud-docker.pkg.coding.net/hyperf/hyperf/hyperf:${PHP_VERSION}-alpine-v${ALPINE_VERSION}-${ENGINE}${SPEC}
