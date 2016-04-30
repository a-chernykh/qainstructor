#!/bin/bash

set -e

shutdown() {
  pid=`ps -ef|grep puma|grep -v grep|grep -v worker|awk '{ print $2 }'`
  kill -SIGTERM $pid
  wait $pid
  running=0
}

bundle check || bundle install

running=1
trap "shutdown" SIGTERM
bundle exec puma -C puma.rb &

while true; do
  if [ "$running" = "1" ]; then
    sleep 1
  else
    break
  fi
done
