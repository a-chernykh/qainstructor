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
# Do not remove the intermediate container with --rm flag intentionally because it will remove the mounted volume
# https://github.com/docker/docker/pull/16809
docker run -v bundle:/bundle -u root qainstructor_engine /bin/bash -c 'mkdir -p /bundle/cache && chown -R app /bundle'
bin/production.sh run --rm engine bundle install

echo 'Precompiling assets, hold on'
bin/production.sh run --rm engine bundle exec rake assets:precompile

bin/production.sh build rails

mkdir /jobs
bin/production.sh build sidekiq

docker volume create --name sample-app-assets
docker run -v sample-app-assets:/sample-app-assets -u root qainstructor_sample-app /bin/bash -c 'cp -rf /app/public/* /sample-app-assets/ && chmod -R a+r /sample-app-assets/'
bin/production.sh build nginx
