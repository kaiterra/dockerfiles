FROM python:3.5.3

ENV PIP_PACKAGES matplotlib==2.1.0 numpy==1.14.5 scipy==1.1.0


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

