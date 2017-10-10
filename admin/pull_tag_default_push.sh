#!/usr/bin/env bash

# This is an easy way to download and tag a specific version of a just published
# image (by CircleCI) as the default tag for that major release.

: ${NODE_VERSION?"must be set."}

my_dir=`dirname $0`
root_dir="$my_dir/.."

docker pull gbhrdt/spaceglue:node-${NODE_VERSION}
docker pull gbhrdt/spaceglue:node-${NODE_VERSION}-builddeps
docker pull gbhrdt/spaceglue:node-${NODE_VERSION}-onbuild

NODE_MAJOR="${NODE_VERSION%%.*}"

docker tag \
  gbhrdt/spaceglue:node-${NODE_VERSION} \
  gbhrdt/spaceglue:node-${NODE_MAJOR}

docker tag \
  gbhrdt/spaceglue:node-${NODE_VERSION}-builddeps \
  gbhrdt/spaceglue:node-${NODE_MAJOR}-build-deps

docker tag \
  gbhrdt/spaceglue:node-${NODE_VERSION}-onbuild \
  gbhrdt/spaceglue:node-${NODE_MAJOR}-onbuild

docker push gbhrdt/spaceglue:node-${NODE_MAJOR}
docker push gbhrdt/spaceglue:node-${NODE_MAJOR}-builddeps
docker push gbhrdt/spaceglue:node-${NODE_MAJOR}-onbuild
