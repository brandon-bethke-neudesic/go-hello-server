FROM golang:latest

RUN mkdir -p /go/src/hello-server
WORKDIR /go/src/hello-server
ENV GO15VENDOREXPERIMENT 1
COPY ./src/hello-server/* /go/src/hello-server

RUN go-wrapper download
RUN go-wrapper install

ENTRYPOINT go-wrapper run
