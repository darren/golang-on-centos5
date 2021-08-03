#!/usr/bin/env bash

VERSION=1.16.6
ARTIFACT=go${VERSION}-CentOS5.linux-amd64.tar.xz
IMAGE_TAG=centos5-go${VERSION}
SOURCE_DIR=go-src
SOURCE_TGZ=go${VERSION}.src.tar.gz

function FAIL() {
    echo "$1"
    exit 1
}

if [[ ! -r $SOURCE_TGZ ]]; then
    wget https://dl.google.com/go/$SOURCE_TGZ
fi

if [[ ! -r $SOURCE_TGZ  ]]; then
    FAIL "$SOURCE_TGZ  not found"
fi

if [[ -r $SOURCE_DIR ]]; then
    echo "Clean files"
    rm -rf $SOURCE_DIR
fi

tar zxf $SOURCE_TGZ
mv go $SOURCE_DIR 
patch -p1 -d $SOURCE_DIR < go${VERSION}-fix.diff

if [[ -r $SOURCE_DIR ]]; then
    docker build . -t $IMAGE_TAG || FAIL "build failed"
    docker run -d -t $IMAGE_TAG /bin/bash 
    CONTAINER_ID=$(docker ps -alq)
    docker cp $CONTAINER_ID:/go.tar.xz $ARTIFACT
    docker stop $CONTAINER_ID
else 
    FAIL "source not found: go${VERSION}"
fi

if [[ -r $ARTIFACT ]]; then
	echo "Build output: $ARTIFACT"
else 
	FAIL "Build failed"
fi
