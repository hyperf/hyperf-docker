## How to build local

```shell
export PHP_VERSION=8.4 && export ALPINE_VERSION=edge && export SW_VERSION=v6.2.1 && export COMPOSER_VERSION=2.9.8 && export PHP_BUILD_VERSION=84 && docker-compose build alpine-swoole

export PHP_VERSION=8.1 && export ALPINE_VERSION=3.18 && docker-compose build alpine-base
```
