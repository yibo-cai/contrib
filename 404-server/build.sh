#!/bin/sh
set -e

GOLANG_VERSION=1.9
VERSION=1.3
ARCHITECTURE=arm64
image=linaro/defaultbackend-$ARCHITECTURE:$VERSION
docker run --rm -it -v `pwd`:/build -v `pwd`/vendor:/go/src arm64v8/golang:$GOLANG_VERSION /bin/bash -c "cd /build && CGO_ENABLED=0 GOOS=linux GOARCH=$ARCHITECTURE GOARM=6 go build -a -installsuffix cgo -ldflags '-w -s' -o server"
docker build --pull --tag=$image .
echo $image > .docker-tag
