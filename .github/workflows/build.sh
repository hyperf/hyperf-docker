#!/usr/bin/env bash

docker-compose build alpine-$ENGINE

docker login docker.pkg.github.com -u hyperf -p $GITHUB_TOKEN

docker tag hyperf/hyperf:$PHP_VERSION-alpine-v$ALPINE_VERSION-$ENGINE-$SW_VERSION docker.pkg.github.com/hyperf/hyperf-docker/hyperf:$PHP_VERSION-alpine-v$ALPINE_VERSION-$ENGINE-$SW_VERSION

docker push docker.pkg.github.com/hyperf/hyperf-docker/hyperf:$PHP_VERSION-alpine-v$ALPINE_VERSION-$ENGINE-$SW_VERSION
