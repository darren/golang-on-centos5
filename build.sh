#!/usr/bin/env bash

if [[ ! -r go1.4.3 ]]; then
	wget -c https://dl.google.com/go/go1.4.3.linux-amd64.tar.gz
	tar zxf go1.4.3.linux-amd64.tar.gz
	mv go go1.4.3
fi

if [[ ! -r go1.13.4.src.tar.gz ]]; then
	wget https://dl.google.com/go/go1.13.4.src.tar.gz
fi

if [[ -r go1.13.4 ]]; then
  echo "Clean files"
  rm -rf go1.13.4
fi

tar zxf go1.13.4.src.tar.gz
mv go go1.13.4
patch -p1 -d go1.13.4 < go1.13.4-fix.diff

docker build .
