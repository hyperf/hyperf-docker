#!/usr/bin/env bash

# determine swoole version to build.
TASK=${1}

# build sandbox
if [[ ${TASK} == "base" ]]; then
    export PHP_VERSION=7.2 && export ALPINE_VERSION=3.9 && docker-compose build alpine-base
    export PHP_VERSION=7.3 && export ALPINE_VERSION=3.9 && docker-compose build alpine-base
    export PHP_VERSION=7.4 && export ALPINE_VERSION=3.9 && docker-compose build alpine-base
    export PHP_VERSION=7.4 && export ALPINE_VERSION=3.10 && docker-compose build alpine-base
fi