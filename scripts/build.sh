#!/bin/bash

# update docsy
git submodule update --init --recursive

# install npm dependencies
yarn install

# build
# HUGO_ENV="production", enables google Analytics
env HUGO_ENV="production" hugo -D

# container registry
REGISTRY='quay.io/mycontroller-org'
IMAGE_WEBSITE="${REGISTRY}/documentation"
IMAGE_TAG=`git rev-parse --abbrev-ref HEAD`

# debug lines
echo $PWD
ls -alh
git branch

# build image
docker buildx build \
  --push \
  --progress=plain \
  --platform linux/arm/v6,linux/arm/v7,linux/arm64,linux/amd64 \
  --file docker/Dockerfile \
  --tag ${IMAGE_WEBSITE}:${IMAGE_TAG} .
