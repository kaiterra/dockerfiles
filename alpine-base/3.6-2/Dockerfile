FROM alpine:3.6
# Base Alpine Linux image with a couple extra packages that are extremely useful for debugging

ENV ALPINE_PACKAGES ca-certificates strace bind-tools curl bash jq

RUN mkdir -p /opt/app
WORKDIR /opt/app

RUN apk add --no-cache $ALPINE_PACKAGES && \
    update-ca-certificates

COPY zoneinfo.zip /usr/local/go/lib/time/

