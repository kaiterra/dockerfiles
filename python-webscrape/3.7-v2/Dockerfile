FROM python:3.7.1

ENV GECKODRIVER_VERSION v0.23.0
ENV GECKODRIVER_MD5SUM 841507ef7aae0f669041ba45e0126255
# For PhantomJS
ENV DEBIAN_PACKAGES libfontconfig git
ENV DEBIAN_DEV_PACKAGES bzip2

ENV CPLUS_INCLUDE_PATH /usr/local/include
ENV LIBRARY_PATH /usr/local/lib
ENV LD_LIBRARY_PATH /usr/local/lib

RUN apt-get update && apt-get install -y -qq curl \
    && apt-get install -y -qq \
        $DEBIAN_PACKAGES \
        $DEBIAN_DEV_PACKAGES \
    && cd / \
    # Base packages that we'll pretty much always need
    && pip install requests lxml beautifulsoup4==4.5 selenium==3.11 confluent-kafka==0.11.6 \
    # Install Firefox driver for Selenium
    && curl -sSLO https://github.com/mozilla/geckodriver/releases/download/${GECKODRIVER_VERSION}/geckodriver-${GECKODRIVER_VERSION}-linux64.tar.gz \
    && echo "${GECKODRIVER_MD5SUM} geckodriver-${GECKODRIVER_VERSION}-linux64.tar.gz" | md5sum -c \
    && tar zxf geckodriver-${GECKODRIVER_VERSION}-linux64.tar.gz -C /usr/bin \
    && rm geckodriver-${GECKODRIVER_VERSION}-linux64.tar.gz \
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
