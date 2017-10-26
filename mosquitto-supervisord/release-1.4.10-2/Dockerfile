# Contains mosquitto along with supervisord to allow another process
# to be hosted in the same container.  (note that this is normally what Kubernetes pods
# are for, so this container only makes sense if you're using docker swarm)
FROM toke/mosquitto:release-1.4.10-2

RUN apt-get update && apt-get install -y --no-install-recommends \
    supervisor && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

