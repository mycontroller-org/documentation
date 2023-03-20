#!/bin/bash

# this script updateds version information

# version details
export GIT_BRANCH=`git rev-parse --abbrev-ref HEAD`

# update tag, if available
if [ ${GIT_BRANCH} = "HEAD" ]; then
  export GIT_BRANCH=`git describe --abbrev=0 --tags`
fi

# update version number
export VERSION=`echo ${GIT_BRANCH} |  awk 'match($0, /([0-9]*\.[0-9]*\.[0-9]*)$/) { print substr($0, RSTART, RLENGTH) }'`
if [ -z "$VERSION" ]; then
  # takes version from versions file and adds devel suffix with that
  STATIC_VERSION=`grep server= versions.txt | awk -F= '{print $2}'`
  BRANCH_NAME=`git describe --contains --all HEAD`
  export VERSION="${STATIC_VERSION}-devel"
fi
