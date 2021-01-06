#!/bin/bash

set -e

VERSION=edge
if [[ $GITHUB_REF = refs/tags/* ]]; then
    VERSION=${GITHUB_REF#refs/tags/}
elif [[ $GITHUB_REF = refs/heads/* ]]; then
    VERSION=`echo ${GITHUB_REF#refs/heads/} | sed -r 's#/+#-#g'`
elif [[ $GITHUB_REF = refs/pull/* ]]; then
    VERSION=pr-`echo ${GITHUB_REF} | awk -F / '{print $3}'`
fi
TAGS="${INPUT_IMAGE}:${VERSION}"

echo GITHUB_REF is $GITHUB_REF
echo INPUT_IMAGE is $INPUT_IMAGE
echo VERSION is $VERSION
echo TAGS is $TAGS

# Set Action output vars
echo ::set-output name=tags::${TAGS}
echo ::set-output name=version::${VERSION}
echo ::set-output name=created::$(date -u +'%Y-%m-%dT%H:%M:%SZ')
