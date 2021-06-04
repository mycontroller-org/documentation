#!/bin/bash

# update docsy
git submodule update --init --recursive

# install npm dependencies
yarn install

# build
# HUGO_ENV="production", enables google Analytics
env HUGO_ENV="production" hugo -D

# container registry
REGISTRY='quay.io/mycontroller'
ALT_REGISTRY='docker.io/mycontroller'
IMAGE_WEBSITE="documentation"
IMAGE_TAG=`git rev-parse --abbrev-ref HEAD`

# debug lines
echo $PWD
ls -alh
git branch

# build image and push to quay.io
docker buildx build \
  --push \
  --progress=plain \
  --platform linux/arm/v6,linux/arm/v7,linux/arm64,linux/amd64 \
  --file docker/Dockerfile \
  --tag ${REGISTRY}/${IMAGE_WEBSITE}:${IMAGE_TAG} .

# build image and push to docker.io
docker buildx build \
  --push \
  --progress=plain \
  --platform linux/arm/v6,linux/arm/v7,linux/arm64,linux/amd64 \
  --file docker/Dockerfile \
  --tag ${ALT_REGISTRY}/${IMAGE_WEBSITE}:${IMAGE_TAG} .
