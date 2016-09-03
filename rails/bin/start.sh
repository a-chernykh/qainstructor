#!/bin/bash

bundle check || bundle install

bundle exec puma -b tcp://0.0.0.0 -p 8080 --pidfile /tmp/puma.pid -t 8 -w 2
