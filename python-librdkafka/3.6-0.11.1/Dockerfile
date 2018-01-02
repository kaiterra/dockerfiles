FROM python:3.6

ENV LIBRDKAFKA_VERSION 0.11.1

ENV CPLUS_INCLUDE_PATH /usr/local/include
ENV LIBRARY_PATH /usr/local/lib
ENV LD_LIBRARY_PATH /usr/local/lib

RUN apt-get update && apt-get install -y -qq curl \
    && apt-get install -y -qq \
        $DEBIAN_PACKAGES \
        $DEBIAN_DEV_PACKAGES \
    && curl -Lk -o /root/librdkafka-${LIBRDKAFKA_VERSION}.tar.gz https://github.com/edenhill/librdkafka/archive/v${LIBRDKAFKA_VERSION}.tar.gz \
    && tar -xzf /root/librdkafka-${LIBRDKAFKA_VERSION}.tar.gz -C /root \
    && cd /root/librdkafka-${LIBRDKAFKA_VERSION} \
    && ./configure && make && make install && make clean && ./configure --clean \
    && cd / \
    # Base packages that we'll always need
    && pip install requests confluent-kafka==0.11.0 \
    # CLEAN UP
    && apt-get -qq -y --purge remove \
        $DEBIAN_DEV_PACKAGES \
    && apt-get -qq -y autoremove \
    && apt-get -qq -y clean \
    && rm /var/lib/apt/lists/* -Rf


RUN mkdir -p /app
WORKDIR /app

# First only copy requirements.txt, so we only have to re-run the PIP step if that changes
ONBUILD COPY requirements.txt /app
ONBUILD RUN pip3 install -r /app/requirements.txt

