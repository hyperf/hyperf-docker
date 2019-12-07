# Supported tags and respective Dockerfile links

tag format:

- 7.2: php version, support 7.2/7.3/7.4
- alpine: base images, supoort alpine/centos
- v3.9: alpine version, support alpine 3.9 and 3.10
- cli: support base/cli, base for php env, cli add `swoole` to base
- v4.3.12: swoole version

support:

- [`7.2-alpine-v3.9-cli-*`, `7.2-alpine-v3.9-cli`, `latest`](https://github.com/hyperf-cloud/hyperf-docker/blob/master/7.2/alpine/cli/Dockerfile)
- [`7.2-alpine-v3.9-base`](https://github.com/hyperf-cloud/hyperf-docker/blob/master/7.2/alpine/base/Dockerfile)
- [`7.3-alpine-v3.9-cli-*`, `7.3-alpine-v3.9-cli`](https://github.com/hyperf-cloud/hyperf-docker/blob/master/7.3/alpine/cli/Dockerfile)
- [`7.3-alpine-v3.9-base`](https://github.com/hyperf-cloud/hyperf-docker/blob/master/7.3/alpine/base/Dockerfile)
- [`7.4-alpine-v3.9-cli-*`, `7.4-alpine-v3.9-cli`](https://github.com/hyperf-cloud/hyperf-docker/blob/master/7.4/alpine/cli/Dockerfile)
- [`7.4-alpine-v3.9-base`](https://github.com/hyperf-cloud/hyperf-docker/blob/master/7.4/alpine/base/Dockerfile)

# Quick reference

- [hyperf](https://github.com/hyperf)
- [hyperf doc](https://doc.hyperf.io)

# How to use this image

Added [Dockerfile](https://github.com/hyperf-cloud/hyperf-docker/blob/master/Dockerfile) to your project.

# How to build and push images

```bash
# Build base image
./build base

# Build swoole image
./build cli 4.4.12

# Check images
./build publish 4.4.12 --check

# Push images to docker.io
./build publish 4.4.12
```