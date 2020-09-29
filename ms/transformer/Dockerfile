FROM golang:alpine

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh gcc musl-dev make

WORKDIR /go/src/app
COPY . .

ENV GO111MODULE=on

EXPOSE 8080

RUN GOOS=linux GOARCH=amd64 go build -mod=readonly -o /go/bin/app main.go
ENTRYPOINT ["/go/bin/app"]