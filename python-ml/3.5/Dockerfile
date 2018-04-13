FROM python:3.5.3

ENV LIBRDKAFKA_VERSION 0.11.1

ENV CPLUS_INCLUDE_PATH /usr/local/include
ENV LIBRARY_PATH /usr/local/lib
ENV LD_LIBRARY_PATH /usr/local/lib

ENV PIP_PACKAGES APScheduler==3.4.0 bleach==1.5.0 tzlocal==1.4 pytz==2017.3 PyYAML==3.12 requests==2.9.1 protobuf==3.4.0 pycurl==7.43.0 pyparsing==2.2.0 python-dateutil==2.6.1 Markdown==2.6.9 responses==0.8.1 urllib3==1.13.1 Werkzeug==0.12.2 chardet==2.3.0 cookies==2.2.1 cycler==0.10.0 enum34==1.1.6 geopy==1.11.0 h5py==2.7.1 html5lib==0.9999999 Keras==2.1.1 matplotlib==2.1.0 numpy==1.13.3 pandas==0.21.0 python-forecastio==1.3.5 scikit-learn==0.19.1 scipy==1.0.0 six==1.10.0 tensorflow==1.4.0 tensorflow-tensorboard==0.4.0rc2 confluent-kafka==0.11.0

RUN apt-get update && apt-get install -y -qq curl \
    && apt-get install -y -qq \
        $DEBIAN_PACKAGES \
        $DEBIAN_DEV_PACKAGES \
    && curl -Lk -o /root/librdkafka-${LIBRDKAFKA_VERSION}.tar.gz https://github.com/edenhill/librdkafka/archive/v${LIBRDKAFKA_VERSION}.tar.gz \
    && tar -xzf /root/librdkafka-${LIBRDKAFKA_VERSION}.tar.gz -C /root \
    && cd /root/librdkafka-${LIBRDKAFKA_VERSION} \
    && ./configure && make && make install && make clean && ./configure --clean \
    && cd / \
    # Packages that tensorflow and other tools tend to use
    && pip --no-cache-dir install $PIP_PACKAGES \
    # Don't use the default back-end, which requires an X server
    && mkdir -p ~/.config/matplotlib \
    && echo "backend: Agg" > ~/.config/matplotlib/matplotlibrc \
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
ONBUILD RUN pip3 --no-cache-dir install -r /app/requirements.txt

