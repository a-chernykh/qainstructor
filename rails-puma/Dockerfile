FROM qainstructor_engine:latest
MAINTAINER Andrey Chernih <andrey.chernih@gmail.com>

USER app
ENV HOME /home/app

CMD ["bundle", "exec", "puma", "-e", "production", "-b", "tcp://0.0.0.0:8080"]
