#!/usr/bin/env bash

set -e

# determine swoole version to build.
TASK=${1}
CHECK=${!#}

# build base image
if [[ ${TASK} == "base" ]]; then
    export PHP_VERSION=7.4 && export UBUNTU_VERSION=20.10 && docker-compose -f ubuntu.compose.yml build ubuntu-base
fi

# build swoole image
if [[ ${TASK} == "cli" ]]; then
    SWOOLE_VERSION=${2}
    export SWOOLE_VERSION=${SWOOLE_VERSION}
    export PHP_VERSION=7.4 && export UBUNTU_VERSION=20.10 && docker-compose -f ubuntu.compose.yml build ubuntu-cli
fi
