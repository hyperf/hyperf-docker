#!/usr/bin/env bash

set -e

# source environment variables for the time being.
source ./.env

# determine swoole version to build.
TASK=${1}
CHECK=${!#}

function check_or_push() {
    TAG=${1}
    if [[ ${CHECK} == "--check" ]]; then
        echo "Checking $TAG ..."
        version=`docker run hyperf/hyperf:$TAG php -v`
        echo $version | grep -Eo "PHP \d+\.\d+\.\d+"
        swoole=`docker run hyperf/hyperf:$TAG php --ri swoole` && echo $swoole | grep -Eo "Version => \d+\.\d+\.\d+" || echo "No Swoole."
    fi

    if [[ ${CHECK} != "--check" ]]; then
        echo "Publishing "$TAG" ..."
        # Push origin image
        docker push hyperf/hyperf:${TAG}
    fi

    echo -e "\n"
}

function tag_and_push() {
    TAG=${1}
    ORIGIN_TAG=$TAG
    TAG=$TAG"-"$SWOOLE_VERSION

    SWOOLE_VERSION=${2}

    SWOOLE_PV=${SWOOLE_VERSION%\.*}
    SWOOLE_PPV=${SWOOLE_VERSION%%\.*}

    docker tag hyperf/hyperf:"$TAG" hyperf/hyperf:"$ORIGIN_TAG-$SWOOLE_PV"
    docker tag hyperf/hyperf:"$TAG" hyperf/hyperf:"$ORIGIN_TAG-$SWOOLE_PPV"
    docker tag hyperf/hyperf:"$TAG" hyperf/hyperf:"$ORIGIN_TAG"

    check_or_push "$ORIGIN_TAG-$SWOOLE_PV"
    check_or_push "$ORIGIN_TAG-$SWOOLE_PPV"
    check_or_push "$ORIGIN_TAG"
}

# build base image
if [[ ${TASK} == "base" ]]; then
    export PHP_VERSION=7.2 && export ALPINE_VERSION=3.9 && docker-compose build alpine-base

    export PHP_VERSION=7.3 && export ALPINE_VERSION=3.9 && docker-compose build alpine-base
    export PHP_VERSION=7.3 && export ALPINE_VERSION=3.10 && docker-compose build alpine-base
    export PHP_VERSION=7.3 && export ALPINE_VERSION=3.11 && docker-compose build alpine-base

    export PHP_VERSION=7.4 && export ALPINE_VERSION=3.9 && docker-compose build alpine-base
    export PHP_VERSION=7.4 && export ALPINE_VERSION=3.10 && docker-compose build alpine-base
    export PHP_VERSION=7.4 && export ALPINE_VERSION=3.11 && docker-compose build alpine-base
fi

# build base image
if [[ ${TASK} == "dev" ]]; then
    export PHP_VERSION=7.2 && export ALPINE_VERSION=3.9 && docker-compose build alpine-dev

    export PHP_VERSION=7.3 && export ALPINE_VERSION=3.9 && docker-compose build alpine-dev
    export PHP_VERSION=7.3 && export ALPINE_VERSION=3.10 && docker-compose build alpine-dev
    export PHP_VERSION=7.3 && export ALPINE_VERSION=3.11 && docker-compose build alpine-dev

    export PHP_VERSION=7.4 && export ALPINE_VERSION=3.9 && docker-compose build alpine-dev
    export PHP_VERSION=7.4 && export ALPINE_VERSION=3.10 && docker-compose build alpine-dev
    export PHP_VERSION=7.4 && export ALPINE_VERSION=3.11 && docker-compose build alpine-dev
fi

# build swoole image
if [[ ${TASK} == "cli" ]]; then
    SWOOLE_VERSION=${2}
    export SWOOLE_VERSION=${SWOOLE_VERSION}
    export PHP_VERSION=7.2 && export ALPINE_VERSION=3.9 && docker-compose build alpine-cli

    export PHP_VERSION=7.3 && export ALPINE_VERSION=3.9 && docker-compose build alpine-cli
    export PHP_VERSION=7.3 && export ALPINE_VERSION=3.10 && docker-compose build alpine-cli
    export PHP_VERSION=7.3 && export ALPINE_VERSION=3.11 && docker-compose build alpine-cli

    export PHP_VERSION=7.4 && export ALPINE_VERSION=3.9 && docker-compose build alpine-cli
    export PHP_VERSION=7.4 && export ALPINE_VERSION=3.10 && docker-compose build alpine-cli
    export PHP_VERSION=7.4 && export ALPINE_VERSION=3.11 && docker-compose build alpine-cli
fi

if [[ ${TASK} == "publish" ]]; then
    # Push base image
    TAGS="7.2-alpine-v3.9-base 7.3-alpine-v3.9-base 7.3-alpine-v3.10-base 7.3-alpine-v3.11-base 7.4-alpine-v3.9-base 7.4-alpine-v3.10-base 7.4-alpine-v3.11-base"
    for TAG in ${TAGS}; do
        check_or_push $TAG
    done

    SWOOLE_VERSION=${2}
    if [[ ${SWOOLE_VERSION} != "" ]]; then
        TAGS="7.2-alpine-v3.9-cli 7.3-alpine-v3.9-cli 7.3-alpine-v3.10-cli 7.3-alpine-v3.11-cli 7.4-alpine-v3.9-cli 7.4-alpine-v3.10-cli 7.4-alpine-v3.11-cli"
        SWOOLE_VERSION="v${SWOOLE_VERSION}"
        for TAG in ${TAGS}; do
            BASETAG=${TAG}
            check_or_push "${TAG}-${SWOOLE_VERSION}"
            tag_and_push $BASETAG $SWOOLE_VERSION
        done

        # Tag latest image
        docker tag hyperf/hyperf:7.2-alpine-v3.9-cli-"${SWOOLE_VERSION}" hyperf/hyperf:latest
        check_or_push "latest"
    fi
fi
