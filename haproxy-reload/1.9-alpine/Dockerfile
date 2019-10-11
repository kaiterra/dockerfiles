FROM haproxy:1.9-alpine
# haproxy image that also contains some extra stuff to help validate and apply configs

ENV ALPINE_PACKAGES ca-certificates strace bind-tools curl bash jq

RUN apk add --no-cache $ALPINE_PACKAGES && \
	update-ca-certificates

