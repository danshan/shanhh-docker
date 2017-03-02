FROM ubuntu:14.04
MAINTAINER i@shanhh.com

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get update

RUN apt-get install -y curl nodejs nginx build-essential ruby2.2 ruby2.2-dev wget zip python-pip vim git zlib1g-dev graphicsmagick

# install bundler
RUN gem install bundler
RUN mkdir -p /opt/data
ADD Gemfile /opt/data/Gemfile
WORKDIR /opt/data
RUN bundle install

# install pygments
RUN pip install -U pip
RUN pip install pygments --upgrade


