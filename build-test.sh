#!/usr/bin/env bash

# determine swoole version to build.
TASK=${1}

# build sandbox
if [[ ${TASK} == "base" ]]; then
    export PHP_VERSION=7.2 && docker-compose build alpine-v3.9-base
    export PHP_VERSION=7.3 && docker-compose build alpine-v3.9-base
fi