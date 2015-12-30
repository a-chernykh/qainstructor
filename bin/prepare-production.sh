#!/bin/sh

set -e

bin/production.sh build ruby

bin/production.sh build postgres
bin/production.sh build redis
bin/production.sh build test-runner
bin/production.sh build faye
bin/production.sh build selenium-server
bin/production.sh build sample-app

bin/production.sh build engine
docker volume create --name bundle
docker run -v bundle:/bundle -u root qainstructor_engine /bin/bash -c 'mkdir -p /bundle/cache && chown -R app /bundle'
bin/production.sh run --rm engine bundle install

echo 'Precompiling assets, hold on'
bin/production.sh run --rm engine bundle exec rake assets:precompile

bin/production.sh build rails
bin/production.sh build sidekiq

bin/production.sh build nginx
