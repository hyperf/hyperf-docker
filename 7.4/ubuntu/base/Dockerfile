# hyperf/hyperf:7.4
#
# @link     https://www.hyperf.io
# @document https://doc.hyperf.io
# @contact  group@hyperf.io
# @license  https://github.com/hyperf/hyperf/blob/master/LICENSE

ARG UBUNTU_VERSION

FROM ubuntu:$UBUNTU_VERSION

LABEL maintainer="Hyperf Developers <group@hyperf.io>" version="1.0" license="MIT"

RUN set -ex \
    && apt-get update \
    && sh -c '/bin/echo -e "6\n70\n" | apt-get install -y php7.4'
