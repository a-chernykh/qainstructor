FROM qainstructor_engine:latest
MAINTAINER Andrey Chernih <andrey.chernih@gmail.com>

USER app
ENV HOME /home/app

ADD bin/start.sh /usr/local/bin
ADD puma.rb .

EXPOSE 8080

CMD ["/usr/local/bin/start.sh"]
