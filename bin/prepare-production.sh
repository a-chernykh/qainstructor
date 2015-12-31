#!/bin/sh

set -e

echo 'Building containers'
bin/production.sh build ruby
bin/production.sh build postgres
bin/production.sh build redis
bin/production.sh build test-runner
bin/production.sh build faye
bin/production.sh build selenium-server
bin/production.sh build sample-app
bin/production.sh build engine
bin/production.sh build rails
bin/production.sh build sidekiq
bin/production.sh build nginx


echo 'Creating volumes'
docker volume create --name production-assets
docker volume create --name bundle
docker volume create --name sample-app-assets

echo 'Installing bundle'
# Do not remove the intermediate container with --rm flag intentionally because it will remove the mounted volume
# https://github.com/docker/docker/pull/16809
docker run -v bundle:/bundle -u root qainstructor_engine /bin/bash -c 'mkdir -p /bundle/cache && chown -R app /bundle'
bin/production.sh run --rm engine bundle install

echo 'Precompiling assets, hold on'
docker run --env-file=env/common.env --env-file=env/production.env -it -v bundle:/bundle  -v production-assets:/app/public qainstructor_engine bundle exec rake assets:precompile
docker run -v production-assets:/assets qainstructor_engine /bin/bash -c 'cp -rf /app/public/* /assets/'
docker run -v sample-app-assets:/sample-app-assets -u root qainstructor_sample-app /bin/bash -c 'cp -rf /app/public/* /sample-app-assets/ && chmod -R a+r /sample-app-assets/'

echo 'Fixing up docker.sock permissions'
sudo mkdir /jobs
sudo chmod a+rw /var/run/docker.sock

echo 'Preparing database'
bin/production.sh run --rm rails bundle exec rake db:migrate db:seed
