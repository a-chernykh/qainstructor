#!/bin/sh

set -e

echo '*** 1. Creating volumes'
docker volume create --name qainstructor-db
docker volume create --name qainstructor-engine-assets
docker volume create --name qainstructor-sample-app-assets

echo '*** 2. Preparing database'
bin/development.sh run --rm rails bundle exec rake db:create db:migrate db:seed
