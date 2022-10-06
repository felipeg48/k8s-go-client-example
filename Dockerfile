FROM golang:1.19-alpine as base
RUN apk add --update --no-cache git && rm -rf /var/cache/apk/*
RUN go install github.com/go-delve/delve/cmd/dlv@latest

ENV CGO_ENABLED=0
ENV GOROOT=/usr/local/go
# this path will be mounted in deploy-service.yaml
ENV GOPATH=/Users/felipeg1/Progs/Go/code/src
ENV PATH=$PATH:${GOROOT}/bin

# ATTENTION: you want to check, if the path to the project folder is the right one here
WORKDIR /go/src/k8s-go-client-example

# 30123 for delve and 8090 for API calls
EXPOSE 30123 8090

# let's start delve as the entrypoint
ENTRYPOINT ["/go/bin/dlv", "debug", ".", "--listen=:30123", "--accept-multiclient", "--headless=true", "--api-version=2"]