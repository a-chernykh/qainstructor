FROM qainstructor/ruby:latest
MAINTAINER Andrey Chernih <andrey.chernih@gmail.com>

ENV dir /app

RUN mkdir $dir
WORKDIR $dir

RUN gem install bundler --no-ri --no-rdoc

RUN useradd -c 'App user' -m -d /home/app -s /bin/bash app
RUN chown app $dir
USER app
ENV HOME /home/app

COPY Gemfile $dir/
COPY Gemfile.lock $dir/
RUN bundle install --deployment

COPY . .

CMD ["bundle", "exec", "thin", "-p 8080", "start"]

EXPOSE 8080
