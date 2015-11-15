FROM centos:centos6
MAINTAINER teamY <ymd.mobi@gmail.com>

RUN yum -y install epel-release
RUN yum -y install nodejs npm
RUN yum -y install wget
RUN yum -y install which
RUN yum -y install tar
RUN yum -y install util-linux

RUN npm install -g yo generator-hubot
RUN npm install -g hubot coffee-script
RUN npm install -g generator-hubot
RUN npm install -g hubot-slack

RUN useradd -d /hubot -m -s /bin/bash -U hubot

# Log in as hubot user and change directory
USER    hubot
WORKDIR /hubot

RUN curl https://raw.githubusercontent.com/hokaccha/nodebrew/master/nodebrew | perl - setup

ENV HUBOT_SLACK_TOKEN=<YOUR_HUBOT_SLACK_TOKEN>
ENV HUBOT_ADAPTER slack
ENV HUBOT_NAME <YOUR_HUBOT_NAME>
ENV HUBOT_SLACK_TEAM <YOUR_SLACK_TEAM>
ENV HUBOT_SLACK_BOTNAME ${HUBOT_NAME}


RUN yo hubot --owner="<your_name>" --description="" --adapter slack --defaults

RUN npm install --save hubot-cron

RUN export PATH="$HOME/.nodebrew/current/bin:$PATH" && \
        source ~/.bashrc && \
        nodebrew install v0.10.6 && \
        nodebrew use v0.10.6 && \
        npm install --save time

RUN sed -i -e "2i\"hubot-cron\"," external-scripts.json
#CMD bin/hubot -a slack &;
