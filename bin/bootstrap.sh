#!/bin/sh

set -e

echo '*** 1. Building base containers'
bin/build.sh

echo '*** 2. Building service containers'
bin/development.sh build > /dev/null

echo '*** 3. Creating volumes'
docker volume create --name qainstructor-db
docker volume create --name qainstructor-engine-assets
docker volume create --name qainstructor-sample-app-assets

echo '*** 4. Preparing database'
bin/development.sh run --rm rails bundle exec rake db:migrate db:seed > /dev/null
