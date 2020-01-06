#!/usr/bin/env bash

if [[ ! -r go1.4.3 ]]; then
	wget -c https://dl.google.com/go/go1.4.3.linux-amd64.tar.gz
	tar zxf go1.4.3.linux-amd64.tar.gz
	mv go go1.4.3
fi

VERSION=1.13.4
ARTIFACT=go${VERSION}-CentOS5.linux-amd64.tar.xz

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

docker build .
CONTAINER_ID=$(docker ps -alq)
docker cp $CONTAINER_ID:/$ARTIFACT .

if [[ -r $ARTIFACT ]]; then
	echo "Build output: $ARTIFACT"
else 
	echo "Build failed"
fi