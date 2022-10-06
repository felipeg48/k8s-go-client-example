FROM golang:1.19-alpine as base
RUN apk add --update --no-cache git && rm -rf /var/cache/apk/*
RUN go install github.com/go-delve/delve/cmd/dlv@latest

FROM base AS build
WORKDIR /workspace
COPY . .
RUN CGO_ENABLED=0 GOFLAGS="-buildvcs=false" go build -gcflags "all=-N -l" -o ./app

FROM alpine
COPY --from=build /go/bin/dlv /dlv
COPY --from=build /workspace/app /app
ENTRYPOINT [ "/dlv" ]