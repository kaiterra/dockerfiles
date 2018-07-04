FROM python:3.5.3

ENV PIP_PACKAGES APScheduler==3.4.0 bleach==1.5.0 chardet==3.0.4 cookies==2.2.1 gast==0.2.0 grpcio==1.12.1 h5py==2.8.0 idna==2.7 Keras==2.2.0 lightgbm==2.1.1 Markdown==2.6.11 numpy==1.14.5 pandas==0.23.1 protobuf==3.6.0 python-dateutil==2.7.3 python-forecastio==1.4.0 pytz==2018.4 PyYAML==3.12 requests==2.19.1 responses==0.9.0 scikit-learn==0.19.1 scipy==1.1.0 six==1.11.0 sklearn==0.0 tensorboard==1.8.0 tensorflow==1.8.0 termcolor==1.1.0 urllib3==1.23 Werkzeug==0.14.1


RUN apt-get update && apt-get install -y -qq curl \
    #&& apt-get install -y -qq \
    #    $DEBIAN_PACKAGES \
    #    $DEBIAN_DEV_PACKAGES \
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

