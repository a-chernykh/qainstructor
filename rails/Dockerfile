FROM qainstructor/engine:latest
MAINTAINER Andrey Chernih <andrey.chernih@gmail.com>

EXPOSE 8080

CMD ["bundle", "exec", "puma", "-b", "tcp://0.0.0.0", "-p", "8080", "--pidfile", "/tmp/puma.pid", "-t", "8", "-w", "2"]
