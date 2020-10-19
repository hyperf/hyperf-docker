#!/usr/bin/env bash

set -e

export ENGINE=${1}
export VERSION=${2}
export CHECK=${!#}
export TAGS="7.3-alpine-v3.9 7.3-alpine-v3.10 7.3-alpine-v3.11 7.4-alpine-v3.9 7.4-alpine-v3.10 7.4-alpine-v3.11"

function pull() {
    for TAG in ${TAGS}; do
        docker pull docker.pkg.github.com/hyperf/hyperf-docker/hyperf:"${TAG}-${ENGINE}-${VERSION}"
        docker tag docker.pkg.github.com/hyperf/hyperf-docker/hyperf:"${TAG}-${ENGINE}-${VERSION}" hyperf/hyperf:"${TAG}-${ENGINE}-${VERSION}"
    done
}

function push() {
    for TAG in ${TAGS}; do
        PV=${VERSION%\.*}
        PPV=${VERSION%%\.*}

        docker tag hyperf/hyperf:"${TAG}-${ENGINE}-${VERSION}" hyperf/hyperf:"${TAG}-${ENGINE}-${PV}"
        docker tag hyperf/hyperf:"${TAG}-${ENGINE}-${VERSION}" hyperf/hyperf:"${TAG}-${ENGINE}-${PPV}"
        docker tag hyperf/hyperf:"${TAG}-${ENGINE}-${VERSION}" hyperf/hyperf:"${TAG}-${ENGINE}"
        if [[ ${CHECK} != "--check" ]]; then
            echo "Publishing "${TAG}-${ENGINE}" ..."
            docker push hyperf/hyperf:"${TAG}-${ENGINE}"
            docker push hyperf/hyperf:"${TAG}-${ENGINE}-${PV}"
            docker push hyperf/hyperf:"${TAG}-${ENGINE}-${PPV}"
            docker push hyperf/hyperf:"${TAG}-${ENGINE}-${VERSION}"
            br
        fi
    done
}

function check() {
    if [[ ${CHECK} == "--check" ]]; then
        for TAG in ${TAGS}; do
            REALTAG=${TAG}-${ENGINE}-${VERSION}
            echo "Checking ${REALTAG}"
            version=`docker run hyperf/hyperf:$REALTAG php -v`
            echo $version | grep -Eo "PHP \d+\.\d+\.\d+"
            echo "Swoole: "
            swoole=`docker run hyperf/hyperf:$REALTAG php --ri swoole` && echo $swoole | grep -Eo "Version => \d+\.\d+\.\d+" || echo "No Swoole."
            echo "Swow: "
            swow=`docker run hyperf/hyperf:$REALTAG php --ri swow` && echo $swow | grep -Eo "Version => \d+\.\d+\.\d+" || echo "No Swow."
            br
        done
    fi
}

function br() {
    echo -e "\n"
}

if [[ ${ENGINE} != "" && ${VERSION} != "" ]]; then
    pull
    br
    check
    br
    push
fi

