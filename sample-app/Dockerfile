FROM qainstructor/ruby:latest
MAINTAINER Andrey Chernih <andrey.chernih@gmail.com>

ENV dir /app

RUN mkdir $dir
WORKDIR $dir

RUN gem install bundler --no-ri --no-rdoc

COPY Gemfile $dir/
COPY Gemfile.lock $dir/
RUN bundle install

COPY . .

CMD ["ruby", "app.rb", "-o", "0.0.0.0", "-p", "8080"]

EXPOSE 8080
