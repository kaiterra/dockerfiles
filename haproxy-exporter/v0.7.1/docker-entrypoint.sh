#!/bin/sh -e

# HAPROXY_INDEX is set to 0 or 1 depending on which haproxy to get
if test "$HAPROXY_INDEX" = "0"; then
    HAPROXY_IP=$(nslookup $HAPROXY_DNS_NAME | grep "^Address.*\.monitor$" | awk '{print $3}' | sort | head -n 1)
else
    HAPROXY_IP=$(nslookup $HAPROXY_DNS_NAME | grep "^Address.*\.monitor$" | awk '{print $3}' | sort | tail -n 1)
fi

if test -z "$HAPROXY_IP"; then
    echo "Error: couldn't resolve $HAPROXY_DNS_NAME"
    exit 1
fi

echo "Connecting to $HAPROXY_IP... with args $@"
set -- "$@" -haproxy.scrape-uri="http://${HAPROXY_IP}${HAPROXY_SCRAPE_URI_SUFFIX}"

exec "$@"
