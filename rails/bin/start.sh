#!/bin/bash

set -e

shutdown() {
  pid=`ps -ef|grep rails|grep -v grep|awk '{ print $2 }'`
  kill -SIGTERM $pid
  wait $pid
  running=0
}

bundle check || bundle install

running=1
trap "shutdown" SIGTERM
bundle exec rails server -b 0.0.0.0 -p 8080 &

while true; do
  if [ "$running" = "1" ]; then
    sleep 1
  else
    break
  fi
done
