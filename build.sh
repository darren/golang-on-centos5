#!/usr/bin/env bash

VERSION=1.13.4
ARTIFACT=go${VERSION}-CentOS5.linux-amd64.tar.xz
IMAGE_TAG=centos5-go${VERSION}

if [[ ! -r go${VERSION}.src.tar.gz ]]; then
	wget https://dl.google.com/go/go${VERSION}.src.tar.gz
fi

if [[ -r go${VERSION} ]]; then
  echo "Clean files"
  rm -rf go${VERSION}
fi

tar zxf go${VERSION}.src.tar.gz
mv go go${VERSION}
patch -p1 -d go${VERSION} < go${VERSION}-fix.diff

docker build . -t $IMAGE_TAG
docker run -d -t $IMAGE_TAG /bin/bash 
CONTAINER_ID=$(docker ps -alq)
docker cp $CONTAINER_ID:/$ARTIFACT .
docker stop $CONTAINER_ID

if [[ -r $ARTIFACT ]]; then
	echo "Build output: $ARTIFACT"
else 
	echo "Build failed"
fi