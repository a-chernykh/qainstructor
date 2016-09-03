FROM ubuntu:trusty
MAINTAINER andrey.chernih@gmail.com

RUN apt-get update && \
    apt-get install -y wget && \
    echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' > /etc/apt/sources.list.d/pgdg.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    apt-get update && \
    apt-get install -y postgresql-contrib-9.4

RUN apt-get install -y python-pip python && \
    pip install awscli

ADD *.sh /usr/local/bin/
ADD backup-cron /etc/cron.d/backup-cron
RUN chmod 0644 /etc/cron.d/backup-cron

RUN touch /var/log/cron.log

CMD /usr/local/bin/cron.sh
