FROM ubuntu
MAINTAINER Andrey Chernih <andrey.chernih@gmail.com>

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-add-repository ppa:brightbox/ruby-ng && \
    apt-get update && \
    apt-get install -y ruby2.2 \
                       ruby2.2-dev \
                       zlib1g-dev \
                       build-essential \
