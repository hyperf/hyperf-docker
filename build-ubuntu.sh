#!/usr/bin/env bash

set -e

# determine swoole version to build.
TASK=${1}
CHECK=${!#}

# build base image
if [[ ${TASK} == "base" ]]; then
    export PHP_VERSION=7.4 && export UBUNTU_VERSION=20.10 && docker-compose build ubuntu-base
fi
