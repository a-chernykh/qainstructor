FROM qainstructor/ruby:latest
MAINTAINER Andrey Chernih <andrey.chernih@gmail.com>

ENV dir /suite

RUN mkdir $dir
WORKDIR $dir

RUN apt-get update && \
    apt-get install -y git

RUN gem install bundler --no-ri --no-rdoc

COPY files/selenium-webdriver-2.49.0.dev.gem /tmp/selenium-webdriver-2.49.0.dev.gem
RUN gem install /tmp/selenium-webdriver-2.49.0.dev.gem

COPY Gemfile $dir/
COPY Gemfile.lock $dir/
RUN bundle install

COPY . .

CMD ["bin/loop.sh"]
