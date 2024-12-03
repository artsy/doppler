#!/bin/sh

set +x
wget https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-linux64.tar.gz -O /tmp/geckodriver.tar.gz && \
  tar xvf /tmp/geckodriver.tar.gz -C /opt && \
  ln -fs /opt/geckodriver /usr/bin/geckodriver

apt-get update && \
  apt-get install -y xvfb firefox-esr

firefox --version
geckodriver --version

xvfb-run bundle exec rake
