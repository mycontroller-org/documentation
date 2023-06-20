# MyController documentation and website
![publish container images](https://github.com/mycontroller-org/documentation/actions/workflows/publish_container_images.yaml/badge.svg)

This repository contains MyController live [website and documentation](https://v2.mycontroller.org). Live always hosts master branch.<br>

You can host it privately on your environment. If you are looking for a specific version.<br>

## Live
* https://v2.mycontroller.org

## Download
### Container images
  * [Docker Hub](https://hub.docker.com/u/mycontroller)
  * [Quay.io](https://quay.io/organization/mycontroller)

`master` branch images are tagged as `:2.x.x-devel`<br>

## Setup development environment
### Pre Requests
* [HUGO](https://gohugo.io/) - Install with extended support

### Setup
```
# update docsy theme dependency
git submodule update --init --recursive

# download npm dependencies
yarn install

# run
hugo serve -D
```
You can see a message,
```
Web Server is available at //localhost:1313/ (bind address 127.0.0.1)
```
On your browser you can access it on the specified address.<br>
Your changes will be updated dynamically.