#!/usr/bin/env bash

set -e

function check_or_push() {
    local TAG=${1}
    if [[ "${2}" == "--check" ]]; then
        echo "Checking $TAG ..."
        docker run hyperf/hyperf:$TAG php -v | grep -Eo "PHP \d+\.\d+\.\d+"
        docker run hyperf/hyperf:$TAG php --ri swoole | grep -Eo "Version => \d+\.\d+\.\d+" || echo "Not found Swoole."
    else
        echo "Publishing \"$TAG\" ..."
        docker push hyperf/hyperf:${TAG}
    fi

    echo -e "\n"
}

# build base image
case ${1} in
base)
    docker-compose build -f ubuntu.compose.yml --build-arg PHP_VERSION=7.4 --build-arg UBUNTU_VERSION=20.10 ubuntu-base
    ;;
cli)
    docker-compose -f ubuntu.compose.yml build --build-arg PHP_VERSION=7.4 --build-arg UBUNTU_VERSION=20.10 --build-arg SWOOLE_VERSION=${2} ubuntu-cli
    ;;
build)
    docker-compose build --build-arg PHP_VERSION=7.3 --build-arg ALPINE_VERSION=3.10 alpine-base
    docker-compose build --build-arg PHP_VERSION=7.3 --build-arg ALPINE_VERSION=3.11 alpine-base

    docker-compose build --build-arg PHP_VERSION=7.4 --build-arg ALPINE_VERSION=3.10 alpine-base
    docker-compose build --build-arg PHP_VERSION=7.4 --build-arg ALPINE_VERSION=3.11 alpine-base
    docker-compose build --build-arg PHP_VERSION=7.4 --build-arg ALPINE_VERSION=3.12 alpine-base
    docker-compose build --build-arg PHP_VERSION=7.4 --build-arg ALPINE_VERSION=3.13 alpine-origin-base
    docker-compose build --build-arg PHP_VERSION=7.4 --build-arg ALPINE_VERSION=3.14 alpine-origin-base
    docker-compose build --build-arg PHP_VERSION=7.4 --build-arg ALPINE_VERSION=3.15 alpine-origin-base

    docker-compose build --build-arg PHP_VERSION=8.0 --build-arg ALPINE_VERSION=3.11 alpine-base
    docker-compose build --build-arg PHP_VERSION=8.0 --build-arg ALPINE_VERSION=3.12 alpine-base
    docker-compose build --build-arg PHP_VERSION=8.0 --build-arg ALPINE_VERSION=3.13 alpine-origin-base
    docker-compose build --build-arg PHP_VERSION=8.0 --build-arg ALPINE_VERSION=3.14 alpine-origin-base
    docker-compose build --build-arg PHP_VERSION=8.0 --build-arg ALPINE_VERSION=3.15 alpine-origin-base
    docker-compose build --build-arg PHP_VERSION=8.0 --build-arg ALPINE_VERSION=3.16 alpine-origin-base

    docker-compose build --build-arg PHP_VERSION=8.1 --build-arg ALPINE_VERSION=3.12 alpine-base
    docker-compose build --build-arg PHP_VERSION=8.1 --build-arg ALPINE_VERSION=3.13 alpine-base
    docker-compose build --build-arg PHP_VERSION=8.1 --build-arg ALPINE_VERSION=3.14 alpine-base
    docker-compose build --build-arg PHP_VERSION=8.1 --build-arg ALPINE_VERSION=3.15 alpine-base
    docker-compose build --build-arg PHP_VERSION=8.1 --build-arg ALPINE_VERSION=3.16 alpine-origin-base
    ;;
publish)
    TAGS=(7.3-alpine-v3.10-base 7.3-alpine-v3.11-base 7.4-alpine-v3.10-base 7.4-alpine-v3.11-base 7.4-alpine-v3.12-base 7.4-alpine-v3.13-base 7.4-alpine-v3.14-base 7.4-alpine-v3.15-base 8.0-alpine-v3.11-base 8.0-alpine-v3.12-base 8.0-alpine-v3.13-base 8.0-alpine-v3.14-base 8.0-alpine-v3.15-base 8.1-alpine-v3.12-base 8.1-alpine-v3.13-base 8.1-alpine-v3.14-base 8.1-alpine-v3.15-base)
    for TAG in "${TAGS[@]}"; do
        check_or_push "$TAG" $2
    done
    ;;
esac
