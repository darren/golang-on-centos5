#!/usr/bin/env bash

if [[ ! -r go1.4.3 ]]; then
	wget -c https://dl.google.com/go/go1.4.3.linux-amd64.tar.gz
	tar zxvf go1.4.3.linux-amd64.tar.gz
	mv go go1.4.3
fi

if [[ ! -r go1.12.4 ]]; then
	wget -c https://dl.google.com/go/go1.12.4.src.tar.gz
	tar zxvf go1.12.4.src.tar.gz
	mv go go1.12.4
fi

docker build .
