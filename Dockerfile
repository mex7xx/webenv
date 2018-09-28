
#build stage

FROM golang:alpine AS builder
ARG http_proxy
ARG https_proxy

WORKDIR /go/src/app
COPY . .

#RUN apk add --no-cache git
RUN go get -d -v ./...
RUN go install -v ./...


#final stage
FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder /go/bin/app /app
ENTRYPOINT ./app
LABEL Name=src Version=0.0.1
EXPOSE 8080
RUN cat /etc/passwd
RUN addgroup -g 1000 -S username && \
    adduser -u 1000 -S username -G username
RUN cat /etc/passwd
USER username
RUN cat /etc/passwd
CMD [app]
