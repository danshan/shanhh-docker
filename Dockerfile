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

EXPOSE 80

RUN mkdir /jekyll
ADD blog /jekyll/blog
ADD qiniu /jekyll/qiniu
WORKDIR /jekyll/blog
RUN jekyll build

RUN rm -rf /etc/nginx/sites-enabled/default
ADD nginx/shanhh.com /etc/nginx/sites-available/shanhh.com
RUN ln -s /etc/nginx/sites-available/shanhh.com /etc/nginx/sites-enabled/shanhh.com

ADD bin/entrypoint.sh /jekyll/entrypoint.sh


ENTRYPOINT ["/jekyll/entrypoint.sh"]
