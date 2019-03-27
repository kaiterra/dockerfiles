FROM python:3.7.1

ENV GECKODRIVER_VERSION v0.23.0
ENV GECKODRIVER_MD5SUM 841507ef7aae0f669041ba45e0126255
# For PhantomJS
ENV DEBIAN_PACKAGES libfontconfig unzip
ENV DEBIAN_DEV_PACKAGES bzip2

ENV CPLUS_INCLUDE_PATH /usr/local/include
ENV LIBRARY_PATH /usr/local/lib
ENV LD_LIBRARY_PATH /usr/local/lib

# Maybe also see https://github.com/GovTechSG/cicd-images/blob/master/robot-selenium/Dockerfile

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update && apt-get install -y -qq curl \
    && apt-get install -y -qq \
        $DEBIAN_PACKAGES \
        $DEBIAN_DEV_PACKAGES \
        ${CHROME_VERSION:-google-chrome-stable} \
    && cd / \
    # Base packages that we'll pretty much always need
    && pip install requests lxml beautifulsoup4==4.5 selenium==3.11 confluent-kafka==0.11.6 \
    # CLEAN UP
    && apt-get -qq -y --purge remove \
        $DEBIAN_DEV_PACKAGES \
    && apt-get -qq -y autoremove \
    && apt-get -qq -y clean \
    && rm /etc/apt/sources.list.d/google-chrome.list \
    && rm /var/lib/apt/lists/* /var/cache/apt/* -Rf

#USER seluser

#============================================
# Chrome webdriver
#============================================
#ARG CHROME_DRIVER_VERSION="latest"
#ARG CHROME_DRIVER_VERSION="74.0.3729.6"

RUN google-chrome --version > chrome_version \
  && CHROME_VERSION=$(cat chrome_version | cut -d. -f-3) \
  && CHROMEDRIVER_VERSION=`curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_VERSION##* }` \
  && echo "Using chromedriver version: "$CHROMEDRIVER_VERSION \
  && wget --no-verbose -O /tmp/chromedriver_linux64.zip "https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip" \
  && rm -rf /opt/selenium/chromedriver \
  && unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CD_VERSION \
  && chmod 755 /opt/selenium/chromedriver-$CD_VERSION \
  && ln -fs /opt/selenium/chromedriver-$CD_VERSION /usr/bin/chromedriver

#COPY generate_config /opt/bin/generate_config

#=================================
# Chrome Launch Script Modification
#=================================
#COPY chrome_launcher.sh /opt/google/chrome/google-chrome


RUN mkdir -p /app
WORKDIR /app

# First only copy requirements.txt, so we only have to re-run the PIP step if that changes
ONBUILD COPY requirements.txt /app
ONBUILD RUN pip3 install -r /app/requirements.txt
