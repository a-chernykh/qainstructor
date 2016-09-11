FROM qainstructor/ruby:latest
MAINTAINER Andrey Chernih <andrey.chernih@gmail.com>

ENV dir /app
ENV APP_USER app
ENV APP_USER_HOME /home/app
ENV BUNDLE_PATH /bundle/cache
ENV BUNDLE_APP_CONFIG $BUNDLE_PATH

RUN mkdir $dir
WORKDIR $dir

RUN apt-get update && apt-get install -y build-essential git libpq-dev nodejs
RUN gem install bundler --no-ri --no-rdoc

RUN useradd --uid 1000 --gid 50 -c 'App user' -m -d $APP_USER_HOME -s /bin/bash $APP_USER

ADD Gemfile $dir/
ADD Gemfile.lock $dir/
RUN bundle install --deployment --path $BUNDLE_PATH && \
      chown -R $APP_USER $BUNDLE_PATH

ADD . $dir/
RUN chown -R app $dir

USER app
ENV HOME /home/app
