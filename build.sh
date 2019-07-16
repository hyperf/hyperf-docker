#!/usr/bin/env bash

set -e
set -x

SWOOLE_V=$1
SWOOLE_PV=${SWOOLE_V%\.*}
SWOOLE_PPV=${SWOOLE_V%%\.*}

# Build base.Dockerfile
# Build php7.2
docker build ./7.2/alpine/base/ -t hyperf/hyperf:7.2-alpine-base
# Build php7.3
docker build ./7.3/alpine/base/ -t hyperf/hyperf:7.3-alpine-base

# Push base images.
docker push hyperf/hyperf:7.2-alpine-base
docker push hyperf/hyperf:7.3-alpine-base

if  [ "$SWOOLE_V" != "" ] ; then
    # Build cli.Dockerfile with Swoole Version.
    # Build php7.2
    docker build ./7.2/alpine/cli/ --build-arg swoole=$SWOOLE_V -t hyperf/hyperf:7.2-alpine-cli-$SWOOLE_V
    docker tag hyperf/hyperf:7.2-alpine-cli-$SWOOLE_V hyperf/hyperf:7.2-alpine-cli-$SWOOLE_PV
    docker tag hyperf/hyperf:7.2-alpine-cli-$SWOOLE_V hyperf/hyperf:7.2-alpine-cli-$SWOOLE_PPV
    docker tag hyperf/hyperf:7.2-alpine-cli-$SWOOLE_V hyperf/hyperf:7.2-alpine-cli

    # Build latest
    docker tag hyperf/hyperf:7.2-alpine-cli-$SWOOLE_V hyperf/hyperf:latest

    # Build php7.3
    docker build ./7.3/alpine/cli/ --build-arg swoole=$SWOOLE_V -t hyperf/hyperf:7.3-alpine-cli-$SWOOLE_V
    docker tag hyperf/hyperf:7.3-alpine-cli-$SWOOLE_V hyperf/hyperf:7.3-alpine-cli-$SWOOLE_PV
    docker tag hyperf/hyperf:7.3-alpine-cli-$SWOOLE_V hyperf/hyperf:7.3-alpine-cli-$SWOOLE_PPV
    docker tag hyperf/hyperf:7.3-alpine-cli-$SWOOLE_V hyperf/hyperf:7.3-alpine-cli

    # Push swoole version a.b.*
    docker push hyperf/hyperf:7.2-alpine-cli
    docker push hyperf/hyperf:7.2-alpine-cli-$SWOOLE_V

    docker push hyperf/hyperf:7.3-alpine-cli
    docker push hyperf/hyperf:7.3-alpine-cli-$SWOOLE_V

    # Push swoole version a.*
    docker push hyperf/hyperf:7.2-alpine-cli-$SWOOLE_PV
    docker push hyperf/hyperf:7.3-alpine-cli-$SWOOLE_PV


    # Push swoole version *.
    docker push hyperf/hyperf:latest
    docker push hyperf/hyperf:7.2-alpine-cli-$SWOOLE_PPV
    docker push hyperf/hyperf:7.3-alpine-cli-$SWOOLE_PPV
fi