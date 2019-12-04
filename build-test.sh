#!/usr/bin/env bash

# determine swoole version to build.
TASK=${1}

function push() {
    TAG=${1}
    # Push origin image
    docker push hyperf/hyperf:${TAG}
    # Push abbreviated image, default alpine version is v3.9
    TAG=`echo $TAG | sed "s/-v3.9//g"`
    docker push hyperf/hyperf:${TAG}
}

# build sandbox
if [[ ${TASK} == "base" ]]; then
    export PHP_VERSION=7.2 && export ALPINE_VERSION=3.9 && docker-compose build alpine-base
    export PHP_VERSION=7.3 && export ALPINE_VERSION=3.9 && docker-compose build alpine-base
    export PHP_VERSION=7.4 && export ALPINE_VERSION=3.9 && docker-compose build alpine-base
    export PHP_VERSION=7.4 && export ALPINE_VERSION=3.10 && docker-compose build alpine-base
fi

if [[ ${TASK} == "publish" ]]; then
    # Push base image
    TAGS="7.2-alpine-v3.9-base 7.3-alpine-v3.9-base 7.4-alpine-v3.9-base 7.4-alpine-v3.10-base"
    for TAG in ${TAGS}; do
        push $TAG
    done
fi