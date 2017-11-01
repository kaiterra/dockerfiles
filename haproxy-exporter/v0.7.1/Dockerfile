FROM quay.io/prometheus/haproxy-exporter:v0.7.1

COPY ./docker-entrypoint.sh /

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "/bin/haproxy_exporter" ]

