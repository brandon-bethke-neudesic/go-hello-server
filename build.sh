#!/bin/bash
if [[ "$1" != "preserve-go-path" ]]; then
	export GOPATH=`pwd`
fi
go get hello-server
if [[ $? -ne 0 ]]; then
    exit 1
fi
BUILD_NUMBER=$(date -u +%Y%m%d%H%M%S)
go install hello-server
if [[ $? -ne 0 ]]; then
    exit 1
fi
if [ -f /usr/local/bin/hello-server ]; then
    echo Removing existing symbolic link
    rm /usr/local/bin/hello-server
fi
echo Creating symbolic link for tpm in /usr/local/bin
ln -s $GOPATH/bin/hello-server /usr/local/bin/hello-server

echo Creating linux version
mkdir -p $GOPATH/bin/linux
env GOPATH=$GOPATH GOOS=linux GOARCH=amd64 go build -o $GOPATH/bin/linux/hello-server hello-server 

